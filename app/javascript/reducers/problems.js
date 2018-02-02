import _ from 'lodash'
import immer from 'immer'
import { createReducer } from 'redux-act'
import { initalState } from './initialState'
import * as actions from '../actions'
import { PiercedLocationState } from '../components/admin/problem/constants'

const createProblem = state => {
  const piercedLocationStateList = state.meta.piercedLocations.map((l, i) => ({
    id: l.id,
    level: PiercedLocationState.L0,
    target: state.meta.targets[i]
  }))
  return {
    name: '',
    piercedLocationStateList
  }
}

const generateTargetLocation = (source, locations) => {
  const min = _.min(locations) - 3
  const max = _.max(locations) + 3
  return source
    .split('\n')
    .slice(min, max)
    .join('\n')
}

const problems = createReducer(
  {
    [actions.initializeMetaOfProblemEditor]: (state, payload) => {
      const { piercedLocations, javaMainContents } = payload
      const filenames = piercedLocations.map(p => p.file_name)
      const sources = filenames.map(f => _.first(javaMainContents.map(j => j[f]).filter(s => s)))
      const targets = sources.map((s, i) => generateTargetLocation(s, piercedLocations[i].lines))

      const nextState = immer(state, draft => {
        draft.meta.piercedLocations = payload.piercedLocations
        draft.meta.javaMainContents = payload.javaMainContents
        draft.meta.targets = targets
      })
      return nextState
    },
    [actions.addProblem]: (state, payload) => {
      const planeProblemsData = createProblem(state)
      const nextState = immer(state, draft => {
        draft.data.push(planeProblemsData)
      })
      return nextState
    }
  },
  initalState.problems
)

export default problems

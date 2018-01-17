import _ from 'lodash'
import immer from 'immer'
import { createReducer } from 'redux-act'
import { initalState } from './initialState'
import * as actions from '../actions'

const concat = (maybeArray, target) => {
  if (_.isArray(maybeArray)) {
    return maybeArray.concat(target)
  }
  return target
}

const piercedLocation = createReducer(
  {
    [actions.updatePiercedLocation]: (state, payload) => {
      const { name, lines } = payload
      const newState = immer(state, draft => {
        draft[name] = draft[name] || []
        draft[name].push([...lines])
      })
      return newState
    },
    [actions.removePiercedLocation]: (state, payload) => {
      const { name, lines } = payload
      let index = state[name].findIndex(itr => _.difference(itr, lines).length === 0)
      const prevLines = _.get(state, [index, 'lines'], [])
      const newState = immer(state, draft => {
        _.remove(draft[name], (_v, idx) => idx === index)
      })
      return newState
    }
  },
  initalState.piercedLocation
)

export default piercedLocation

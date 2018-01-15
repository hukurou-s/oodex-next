import _ from 'lodash'
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
      const index = state.findIndex(d => d.name === name)
      const prevLines = _.get(state, [index, 'lines'], [])
      if (state[index]) {
        state[index] = { name, lines: concat(prevLines, lines) }
      } else {
        state.push({ name, lines: concat(prevLines, lines) })
      }
      return [...state]
    },
    [actions.removePiercedLocation]: (state, payload) => {
      const { name, lines } = payload
      const index = state.findIndex(itr => itr.name === name)
      const prevLines = _.get(state, [index, 'lines'], [])
      state[index] = {
        name,
        lines: _.difference(prevLines, lines)
      }
      return [...state]
    }
  },
  initalState.piercedLocation
)

export default piercedLocation

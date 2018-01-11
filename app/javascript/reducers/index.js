import { combineReducers } from 'redux'
import { createReducer } from 'redux-act'

const initalState = {
  sample: ''
}

const sample = createReducer(
  {
    a: (state, _) => {
      return state
    }
  },
  initalState.sample
)

export default combineReducers({
  sample
})

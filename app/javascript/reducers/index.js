import _ from 'lodash'
import { combineReducers } from 'redux'
import piercedLocation from './piercedLocation'
import problems from './problems'

export default combineReducers({
  piercedLocation,
  problems
})

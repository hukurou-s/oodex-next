import { createStore, applyMiddleware, compose } from 'redux'
import { createLogger } from 'redux-logger'
import reducer from '../../reducers/exercise'

const logger = createLogger()

export default () => {
  const middlewares = []
  middlewares.push(logger)
  const store = compose(applyMiddleware(...middlewares))(createStore)(reducer)
  return store
}

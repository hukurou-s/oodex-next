import createSagaMiddleware from 'redux-saga'
import { createStore, applyMiddleware, compose } from 'redux'
import { createLogger } from 'redux-logger'
import reducer from '../reducers'
import rootSaga from '../sagas'

const logger = createLogger()

export default () => {
  const middlewares = []
  const sagaMiddleware = createSagaMiddleware()
  middlewares.push(sagaMiddleware)
  middlewares.push(logger)
  const store = compose(applyMiddleware(...middlewares))(createStore)(reducer)
  sagaMiddleware.run(rootSaga)
  return store
}

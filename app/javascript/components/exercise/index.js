import React, { Component } from 'react'
import { Provider } from 'react-redux'
import createStore from '../../stores/exercise'

import TheExercise from './TheExercise'

const store = createStore()

export default function Exercise(props) {
  return (
    <Provider store={store}>
      <div className="container">
        <TheExercise {...props} />
      </div>
    </Provider>
  )
}

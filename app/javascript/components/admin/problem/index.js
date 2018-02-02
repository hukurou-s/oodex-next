import React, { Component } from 'react'
import { Provider } from 'react-redux'
import createStore from '../../../stores'
import TheProblemEditor from './TheProblemEditor'

const store = createStore()

export default function ProblemEditor(props) {
  return (
    <Provider store={store}>
      <div className="container">
        <TheProblemEditor {...props} />
      </div>
    </Provider>
  )
}

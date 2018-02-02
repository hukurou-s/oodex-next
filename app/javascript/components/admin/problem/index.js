import React, { Component } from 'react'
import { Provider } from 'react-redux'
import createStore from '../../../stores'
import TheProblemEditor from './TheProblemEditor'

const store = createStore()

export default function ProblemEditor({ piercedLocations, javaMainContents }) {
  return (
    <Provider store={store}>
      <div className="container">
        <TheProblemEditor piercedLocations={piercedLocations} javaMainContents={javaMainContents} />
      </div>
    </Provider>
  )
}

import React, { Component } from 'react'
import { Provider } from 'react-redux'

import TheExercise from './TheExercise'

export default function Exercise(props) {
  return (
    <div className="container">
      <TheExercise {...props} />
    </div>
  )
}

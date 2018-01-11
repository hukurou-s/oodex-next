import React, { Component } from 'react'
import { Provider } from 'react-redux'
import TheCodeBlock from './TheCodeBlock'
import createStore from '../../../stores'

const store = createStore()

export default function MissonEditor({ java_main_contents }) {
  return (
    <Provider store={store}>
      <div className="container">
        {java_main_contents.map((content, index) =>
          Object.keys(content).map(name => (
            <TheCodeBlock key={name} name={name} code={content[name]} />
          ))
        )}
      </div>
    </Provider>
  )
}

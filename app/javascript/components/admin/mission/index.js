import React, { Component } from 'react'
import { Provider } from 'react-redux'
import Form from './Form'
import TheCodeBlock from './TheCodeBlock'
import createStore from '../../../stores'

const store = createStore()

export default function MissonEditor({ javaMainContents }) {
  return (
    <Provider store={store}>
      <div className="container">
        {javaMainContents.map((content, index) =>
          Object.keys(content).map(name => (
            <TheCodeBlock key={name} name={name} code={content[name]} />
          ))
        )}
        <Form />
      </div>
    </Provider>
  )
}

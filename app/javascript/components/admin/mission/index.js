import React, { Component } from 'react'
import TheCodeBlock from './TheCodeBlock'

export default function MissonEditor({ java_main_contents }) {
  return (
    <div className="container">
      {java_main_contents.map((content, index) =>
        Object.keys(content).map(name => (
          <TheCodeBlock key={name} name={name} code={content[name]} />
        ))
      )}
    </div>
  )
}

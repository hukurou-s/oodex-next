import React from 'react'
import styled from 'styled-components'

const Question = styled.div`
  margin-top: 30px;
`

export default function QuestionContents({ contents }) {
  return (
    <Question>
      <h2>{contents.name}</h2>
      <div>
        <p>{contents.detail}</p>
      </div>
    </Question>
  )
}

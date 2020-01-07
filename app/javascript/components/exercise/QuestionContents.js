import React from 'react'
import styled from 'styled-components'

import QuestionCode from './QuestionCode'
const Question = styled.div`
  margin-top: 30px;
  margin-bottom: 30px;
`

export default function QuestionContents({ contents }) {
  return (
    <Question>
      <div className="columns">
        <div className="column is-10">
          <h2>小問 {contents.name}</h2>
        </div>
        <div className="column is-2">
          <p>
            {contents.currentScore} 点(現在) / {contents.perfectScore} 点(満点)
          </p>
        </div>
      </div>
      <div style={{ margin: '20px', whiteSpace: 'pre-line' }}>
        <p>{contents.detail}</p>
      </div>
      <QuestionCode questionID={contents.id} />
    </Question>
  )
}

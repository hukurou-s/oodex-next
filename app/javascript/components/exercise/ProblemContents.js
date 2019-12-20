import React from 'react'
import styled from 'styled-components'

import ProblemCode from './ProblemCode'
import QuestionContents from './QuestionContents'

const Problem = styled.div`
  margin-top: 30px;
  margin-bottom: 30px;
`

export default function ProblemContents({ contents }) {
  return (
    <Problem>
      <h1>{contents.name}</h1>
      <div>
        <p>{contents.detail}</p>
      </div>
      <ProblemCode problemID={contents.id} />
      <div className="questions">
        {contents.questionList.map((q, i) => {
          return <QuestionContents key={i} contents={q} />
        })}
      </div>
    </Problem>
  )
}

import React from 'react'
import styled from 'styled-components'

import ProblemCode from './ProblemCode'
import QuestionContents from './QuestionContents'

const Problem = styled.div`
  margin-top: 30px;
  margin-bottom: 30px;
`

export default function ProblemContents({ contents }) {
  if (!contents) {
    return (
      <Problem>
        <h1>大問の登録がありません</h1>
        <div style={{ margin: '20px', whiteSpace: 'pre-line' }}>
          <p>大問の登録がないようです。担当教員に確認してください。</p>
        </div>
      </Problem>
    )
  }
  return (
    <Problem>
      <h1>大問 {contents.name}</h1>
      <div style={{ margin: '20px', whiteSpace: 'pre-line' }}>
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

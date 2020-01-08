import React from 'react'
import { connect } from 'react-redux'

import CodeBlock from './CodeBlock'

class QuestionCode extends React.Component {
  constructor(props) {
    super(props)
  }

  renderCode = javaFiles => {
    const files = javaFiles.filter((f, i, arr) => arr.indexOf(f) === i)
    let code = []
    files.forEach((file, i) => {
      const content = this.props.javaPiercedContents.find(content => {
        return Object.keys(content)[0] === file
      })
      code.push(
        <div key={i} style={{ marginTop: 30 }}>
          <CodeBlock id={this.props.questionID} file={file} code={content[file]} type="question" />
        </div>
      )
    })
    return code
  }

  render() {
    const files = this.props.questionsWithTests
      .filter(q => q.question_id === this.props.questionID)
      .map(q => q.file_name)
    return <div>{this.renderCode(files)}</div>
  }
}

export default connect(
  state => ({
    javaPiercedContents: state.problems.meta.javaPiercedContents,
    questionsWithTests: state.problems.meta.questionsWithTests
  }),
  {}
)(QuestionCode)

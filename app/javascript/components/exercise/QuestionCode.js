import React from 'react'
import { connect } from 'react-redux'

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
          <h2>ファイル名: {file}</h2>
          <pre>{content[file]}</pre>
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

import React from 'react'
import { connect } from 'react-redux'

import CodeBlock from './CodeBlock'

class ProblemCode extends React.Component {
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
          <CodeBlock file={file} code={content[file]} />
        </div>
      )
    })
    return code
  }

  render() {
    const files = this.props.problemWithTests
      .filter(p => p.problem_id === this.props.problemID)
      .map(p => p.file_name)
    return <div>{this.renderCode(files)}</div>
  }
}

export default connect(
  state => ({
    javaPiercedContents: state.problems.meta.javaPiercedContents,
    problemWithTests: state.problems.meta.problemsWithTests
  }),
  {}
)(ProblemCode)

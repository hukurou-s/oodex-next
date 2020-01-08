import React from 'react'
import { connect } from 'react-redux'

import axios from 'axios'

import CodeBlock from './CodeBlock'

class ProblemCode extends React.Component {
  constructor(props) {
    super(props)
  }

  handleSubmit = async () => {
    const result = await axios
      .post(
        '/api/submissions/problem',
        {
          id: this.props.problemID,
          file_name: '',
          code: {}
        },
        {
          withCredentials: true
        }
      )
      .then(res => res.data)
      .catch(/*e => console.log(e)*/)
    //console.log(result)
  }

  renderTestButton = () => {
    return (
      <div className="columns">
        <div className="column is-offset-11 is-1">
          <button type="button" className="button is-primary" onClick={this.handleSubmit}>
            テスト
          </button>
        </div>
      </div>
    )
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
          <CodeBlock id={this.props.problemID} file={file} code={content[file]} type="problem" />
        </div>
      )
    })
    return code.length ? code : this.renderTestButton()
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

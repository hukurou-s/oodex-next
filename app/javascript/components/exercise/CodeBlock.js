import React from 'react'
import { connect } from 'react-redux'

import AceEditor from 'react-ace'
import axios from 'axios'

import 'ace-builds/src-noconflict/mode-java'
import 'ace-builds/src-noconflict/theme-solarized_light'

class CodeBlock extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      code: this.props.code,
      endPoint: `/api/submissions/${this.props.type}`
    }
    axios.defaults.headers['x-csrf-token'] = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute('content')
  }

  onChange = newValue => {
    this.setState({ code: newValue })
  }

  createRequestCode = code => {
    let data = {}
    let flag = false
    let location = -1

    code.split('\n').forEach((line, index) => {
      const end = line.match(/\s*(\/\/ !\])/)
      if (end) {
        flag = false
        location = -1
        return
      }

      const start = line.match(/\s*(\/\/ !\[)(\d+)/)
      if (start) {
        flag = true
        location = start[2]
        data[location] = ''
        return
      }

      if (flag) {
        data[location] += '\n' + line
      }
    })
    return data
  }

  handleSubmit = async () => {
    const result = await axios
      .post(
        this.state.endPoint,
        {
          id: this.props.id,
          file_name: this.props.file,
          code: this.createRequestCode(this.state.code)
        },
        {
          withCredentials: true
        }
      )
      .then(res => res.data)
      .catch(/*e => console.log(e)*/)
    //console.log(result)
  }

  render() {
    return (
      <div>
        <div className="columns">
          <div className="column is-11">
            <h2>ファイル名: {this.props.file}</h2>
          </div>
          <div className="column is-1">
            <button type="button" className="button is-primary" onClick={this.handleSubmit}>
              テスト
            </button>
          </div>
        </div>
        <AceEditor
          mode="java"
          theme="solarized_light"
          onChange={this.onChange}
          name="code"
          value={this.state.code}
          width="auto"
          editorProps={{ $blockScrolling: true }}
        />
      </div>
    )
  }
}

export default connect()(CodeBlock)

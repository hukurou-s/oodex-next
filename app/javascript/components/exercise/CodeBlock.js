import React from 'react'
import { connect } from 'react-redux'

import AceEditor from 'react-ace'

import 'ace-builds/src-noconflict/mode-java'
import 'ace-builds/src-noconflict/theme-solarized_light'

class CodeBlock extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      code: this.props.code
    }
  }

  onChange = newValue => {
    this.setState({ code: newValue })
  }

  handleSubmit = () => {
    //console.log('code', this.state.code)
    // request to backend for testing
  }

  render() {
    return (
      <div>
        <div className="columns">
          <div className="column is-11">
            <h2>ファイル名: {this.props.file}</h2>
          </div>
          <div className="column is-11">
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

export default connect(
  state => ({}),
  {}
)(CodeBlock)

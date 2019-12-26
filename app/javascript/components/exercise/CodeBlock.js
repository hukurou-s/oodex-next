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
      code: this.props.code
    }
    axios.defaults.headers['x-csrf-token'] = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute('content')
  }

  onChange = newValue => {
    this.setState({ code: newValue })
  }

  handleSubmit = async () => {
    //console.log('code', this.state.code)
    // request to backend for testing
    const result = await axios
      .post(
        '/api/submissions/question',
        {
          /*
          file_name: this.props.file,
          code: this.state.code
          */
          "id": 6,
	        "file_name": "/src/main/java/sequence/NumSequenceGenerator.java",
	        "code":
	        {
		        1: "NumData[] seq = new NumData[size];\n        for (int i = 0; i < size; i++) {\n            seq[i] = new NumData(i);\n        }\n        return new NumDataSequence(seq);",
		        2: "",
		        3: "",
		        4: "",
	        }
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

import _ from 'lodash'
import React from 'react'
import { connect } from 'react-redux'
import Header from './Header'
import { initializeMetaOfProblemEditor } from '../../../actions'


class TheProblemEditor extends React.Component {
  componentDidMount() {
    const { piercedLocations, javaMainContents } = this.props
    this.props.initializeMetaOfProblemEditor({
      piercedLocations,
      javaMainContents,
    })
  }

  render() {
    return (
      <div>
        <Header />
      </div>
    )
  }
}

export default connect(state => ({}), {
  initializeMetaOfProblemEditor
})(TheProblemEditor)

import _ from 'lodash'
import React from 'react'
import { connect } from 'react-redux'
import Header from './Header'
import { initializeMetaOfProblemEditor } from '../../../actions'
import ThePircedLocationStateEditor from './ThePircedLocationStateEditor'

class TheProblemEditor extends React.Component {
  componentDidMount() {
    const { piercedLocations, javaMainContents, testList } = this.props
    this.props.initializeMetaOfProblemEditor({
      piercedLocations,
      javaMainContents,
      testList
    })
  }

  render() {
    console.log(this.props.testList)
    return (
      <div>
        <Header />
        {this.props.problems.map((p, i) => (
          <ThePircedLocationStateEditor
            key={Math.random()}
            id={i}
            problem={p}
            testList={this.props.testList}
          />
        ))}
      </div>
    )
  }
}

export default connect(
  state => ({
    problems: state.problems.data
  }),
  {
    initializeMetaOfProblemEditor
  }
)(TheProblemEditor)

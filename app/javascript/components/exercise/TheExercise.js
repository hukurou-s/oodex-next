import React from 'react'
import { connect } from 'react-redux'
import { initializeProblemAndQuestionData } from '../../actions/exercise'
import TheProblems from './TheProblems'

class TheExercise extends React.Component {
  componentDidMount() {
    const {
      problemData,
      questionData,
      score,
      problemsWithTests,
      questionsWithTests,
      javaPiercedContents
    } = this.props
    this.props.initializeProblemAndQuestionData({
      problemData,
      questionData,
      score,
      problemsWithTests,
      questionsWithTests,
      javaPiercedContents
    })
  }

  render() {
    return (
      <div>
        <TheProblems problemList={this.props.problems.problemList} />
      </div>
    )
  }
}

export default connect(
  state => ({
    problems: state.problems
  }),
  {
    initializeProblemAndQuestionData
  }
)(TheExercise)

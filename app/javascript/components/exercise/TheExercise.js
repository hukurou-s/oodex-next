import React from 'react'
import { connect } from 'react-redux'
import { initializeProblemAndQuestionData } from '../../actions/exercise'

class TheExercise extends React.Component {
  componentDidMount() {
    console.log(this.props)
    const { problems, questions, problemsWithTests, questionsWithTests } = this.props
    this.props.initializeProblemAndQuestionData({
      problems,
      questions,
      problemsWithTests,
      questionsWithTests
    })
  }

  render() {
    console.log("store", this.props)
    return (
      <div>
        <h1>The Exersice</h1>
      </div>
    )
  }
}

export default connect(
  state => ({}),
  {
    initializeProblemAndQuestionData
  }
)(TheExercise)

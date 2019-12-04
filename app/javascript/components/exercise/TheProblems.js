import React from 'react'
import { connect } from 'react-redux'
import ProblemContents from './ProblemContents'

class TheProblems extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      visibleProblemIndex: 0
    }
  }
  renderTabs = (visibleProblemIndex) => {
    return (
      <div className='tabs'>
        {
          this.props.problemList.map((p, i) => (
            this.renderTab(i, visibleProblemIndex)
          ))
        }
      </div>
    )
  }

  renderTab = (index, visibleProblemIndex) => {
    if ( index === visibleProblemIndex) {
      return (
        <li
          className={index === visibleProblemIndex && 'is-active'}
          key={index}
          onClick={() => {this.changeActiveTab(index)}}
        >
          <a>{`problem${index+1}`}</a>
        </li>
      )
    }
    return (
      <li
        key={index}
        onClick={() => {this.changeActiveTab(index)}}
      >
        <a>{`problem${index+1}`}</a>
      </li>

    )
  }

  changeActiveTab = (index) => {
    this.setState({visibleProblemIndex: index})
  }

  activeProblem = () => {
    const problemList = this.props.problemList
    if ( !Array.isArray(problemList) ) {
      return {}
    }
    return this.props.problemList[this.state.visibleProblemIndex]
  }

  render() {
    const problemList = this.props.problemList
    if ( !Array.isArray(problemList) ) {
      return (
        <div className='problems'>
          <h1>問題が登録されていません</h1>
        </div>
      )
    }
    return (
      <div className='problems'>
        <div className='problem-tabs'>
          {this.renderTabs(this.state.visibleProblemIndex)}
        </div>
        <ProblemContents
          contents={this.activeProblem()}
        />
      </div>
    )
  }
}

export default connect(
  state => ({
    //problems: state.problems.problemList
  }),{}
)(TheProblems)

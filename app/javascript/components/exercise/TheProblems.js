import React from 'react'
import { connect } from 'react-redux'

class TheProblems extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      visibleProblemIndex: 0
    }
  }
  renderTabs = (visibleProblemIndex) => {
    const problemList = this.props.problemList
    console.log(problemList)
    if ( !Array.isArray(problemList) ) {
      return (<h1>問題が登録されていません</h1>)
    }
    return (
      <div className='tabs'>
        {
          problemList.map((p, i) => (
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
          onClick={ () => { this.changeActiveTab(index) }}
        >
          <a>{`problem${index+1}`}</a>
        </li>
      )
    }
    return (
      <li
        key={index}
        onClick={ () => { this.changeActiveTab(index) }}
      >
        <a>{`problem${index+1}`}</a>
      </li>

    )
  }

  changeActiveTab = (index) => {
    this.setState({visibleProblemIndex: index})
  }

  render() {
    return (
      <div className='problems'>
        <div className='problem-tabs'>
          { this.renderTabs(this.state.visibleProblemIndex) }
        </div>
      </div>
    )
  }
}

export default connect(
  state => ({
    //problems: state.problems.problemList
  }),{}
)(TheProblems)

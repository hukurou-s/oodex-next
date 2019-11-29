import React from 'react'
import { connect } from 'react-redux'

class TheProblems extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      visibleProblemIndex: 0
    }
  }
  renderTabs = () => {
    const problemList = this.props.problemList
    console.log(problemList)
    if ( !Array.isArray(problemList) ) {
      return (<h1>問題が登録されていません</h1>)
    }
    return (
      <div className='tabs'>
        {
          problemList.map((p, i) => (
            this.renderTab(i)
          ))
        }
      </div>
    )
  }

  renderTab = (index) => {
    return (
      <li className={index === this.state.visibleProblemIndex && 'is-active'} key={index}>
        <a>{`problem${index+1}`}</a>
      </li>
    )
  }

  render() {
    return (
      <div className='problems'>
        <div className='problem-tabs'>
          { this.renderTabs() }
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

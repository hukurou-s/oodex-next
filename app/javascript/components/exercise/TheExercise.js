import React from 'react'

class TheExercise extends React.Component {
  componentDidMount() {
    console.log(this.props)
  }

  render() {
    return (
      <div>
        <h1>The Exersice</h1>
      </div>
    )
  }
}

export default TheExercise

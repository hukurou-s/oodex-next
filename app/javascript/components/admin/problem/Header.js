import React from 'react'
import { connect } from 'react-redux'
import styled from 'styled-components'
import { addProblem } from '../../../actions'

const Div = styled.div`
  height: 60px;
  width: 100%;
  line-height: 60px;
  background: #e9fffe;
`

const Button = styled.a`
  margin-top: 12px;
  margin-right: 30px;
  float: right;
`

const Header = ({ addProblem }) => {
  return (
    <Div>
      <Button className="button is-primary" onClick={addProblem}>
        問題を追加
      </Button>
    </Div>
  )
}

export default connect(
  state => ({}),
  {
    addProblem
  }
)(Header)

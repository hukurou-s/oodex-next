import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import ReactDOM from 'react-dom'
import autoBind from 'react-autobind'
import styled from 'styled-components'
import hljs from 'highlight.js'
import LineWithNum from './TheLineWithNum'
import { hiddenEndLabel } from './constants'
import { updatePiercedLocation, removePiercedLocation } from '../../../actions'

const Box = styled.div`
  border: 1px solid gray;
  margin-bottom: 3px;
  overflow-y: hidden;
`

const Title = styled.h1`
  line-height: 40px;
  height: 40px;
  font-size: 16px;
  padding-left: 20px;
  display: inline-block;
`

const ToggleButton = styled.span`
  border: 1px solid gray;
  border-radius: 30px;
  padding: 4px;
  width: 44px;
  height: 24px;
  margin: 10px;
  background-color: #f6ffc0;
  cursor: pointer;

  &:hover {
    background-color: #f6ff30;
  }

  &:before {
    content: '開閉';
  }

  &:active {
    background-color: #f6cf30;
  }
`

const generateEmptyBlock = (lines, num) => {
  const newHiddenLines = [num]
  while (!hiddenEndLabel.test(lines[num])) {
    newHiddenLines.push(num++)
  }
  return newHiddenLines
}

class TheCodeBlock extends Component {
  constructor(props) {
    super(props)
    this.state = {
      hidden: true,
      activeHideButtonState: [],
      selected: [],
      hiddenLines: []
    }
    autoBind(this)
  }

  componentDidMount() {
    this.highlight()
  }

  componentDidUpdate() {
    this.highlight()
  }

  highlight() {
    const domNode = ReactDOM.findDOMNode(this)
    const nodes = domNode.querySelectorAll('div > div > code')
    nodes.forEach(node => hljs.highlightBlock(node))
  }

  onToggle() {
    this.setState({ hidden: !this.state.hidden })
  }

  onHide(num) {
    const start = num
    const { code, name } = this.props
    const { hiddenLines, activeHideButtonState } = this.state
    const lines = code.split('\n')

    const newHiddenLines = generateEmptyBlock(lines, num + 1)
    activeHideButtonState.push(start)

    this.props.updatePiercedLocation({
      name,
      lines: _.uniq(newHiddenLines)
    })

    this.setState({ activeHideButtonState })
  }

  onShow(num) {
    const start = num
    const { code, name, piercedLocation } = this.props
    const { activeHideButtonState } = this.state
    const hiddenLines = _.flatten(_.get(piercedLocation, [name], []))
    const lines = code.split('\n')
    const newHiddenLines = _.difference(hiddenLines, generateEmptyBlock(lines, num))

    const index = activeHideButtonState.findIndex(i => i === start)
    if (index !== -1) delete activeHideButtonState[index]

    this.props.removePiercedLocation({
      name,
      lines: generateEmptyBlock(lines, num)
    })

    this.setState({ activeHideButtonState })
  }

  onLineSelect(num) {
    const { selected } = this.state
    const index = selected.findIndex(i => i === num)
    if (index === -1) {
      selected.push(num)
      this.setState({ selected })
    } else {
      selected.splice(index, 1)
    }
    this.setState({ selected })
  }

  render() {
    const { code, name, piercedLocation } = this.props
    const { selected, activeHideButtonState } = this.state
    return (
      <Box>
        <div style={{ borderBottom: '1px solid gray' }}>
          <ToggleButton onClick={this.onToggle} />
          <Title>{name}</Title>
        </div>
        {this.state.hidden
          ? null
          : code
              .split('\n')
              .map((line, i) => (
                <LineWithNum
                  key={i}
                  index={i}
                  line={line}
                  selected={selected}
                  hiddenLines={_.flatten(piercedLocation[name])}
                  activeHideButtonState={activeHideButtonState}
                  onShow={this.onShow}
                  onHide={this.onHide}
                  onLineSelect={this.onLineSelect}
                />
              ))}
      </Box>
    )
  }
}

export default connect(state => ({ piercedLocation: state.piercedLocation }), {
  updatePiercedLocation,
  removePiercedLocation
})(TheCodeBlock)

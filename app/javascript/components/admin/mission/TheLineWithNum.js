import React from 'react'
import styled from 'styled-components'
import ThePiercedButton from './ThePiercedButton'

const Line = styled.code`
  display: ${props => (props.hidden ? 'none' : 'inline-block')};
  white-space: pre;
  padding: 0 0 0 10px;
  color: 'black';
  background: ${props => (props.selected ? '#e6ffed' : 'transparent')};
  overflow-x: unset;
  width: calc(100% - 50px);
`
const Num = styled.span`
  width: 50px;
  font-size: 0.8em;
  text-align: right;
  background-color: ${props => (props.selected ? '#cdffd8' : '#e4e4e4')};
  border-right: 1px solid gray;
  display: inline-block;
  padding-right: 10px;
  font-family: monospace;
  line-height: 22px;
  cursor: pointer;
`

export default ({
  line,
  index,
  selected,
  hiddenLines,
  activeHideButtonState,
  onShow,
  onHide,
  onLineSelect
}) => {
  return (
    <div style={{ height: '22px' }}>
      <Num selected={selected.includes(index)} onClick={() => onLineSelect(index)}>
        {index + 1}
      </Num>
      <Line
        className="java"
        hidden={hiddenLines.includes(index)}
        selected={selected.includes(index)}>
        {line}
      </Line>
      <ThePiercedButton
        hiddenLines={hiddenLines}
        activeHideButtonState={activeHideButtonState}
        line={line}
        index={index}
        onShow={onShow}
        onHide={onHide}
      />
    </div>
  )
}

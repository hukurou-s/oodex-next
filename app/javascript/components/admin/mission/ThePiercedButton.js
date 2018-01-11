import React, { Component } from 'react'
import styled from 'styled-components'
import { hiddenStartLabel } from './constants'

const BaseButton = styled.span`
  color: white;
  cursor: pointer;
  font-weight: 900;
  height: 22px;
  left: calc(100% - 100px);
  position: absolute;
  text-align: center;
  width: 100px;
  z-index: 100;
`

const HideButton = styled(BaseButton)`
  background: red;
`

const ShowButton = styled(BaseButton)`
  background: blue;
`

export default ({ line, index, hiddenLines, activeHideButtonState, onShow, onHide }) =>
  hiddenStartLabel.test(line) ? (
    activeHideButtonState.includes(index) ? (
      <ShowButton onClick={() => onShow(index)}>戻す</ShowButton>
    ) : (
      <HideButton onClick={() => onHide(index)}>穴空にする</HideButton>
    )
  ) : null

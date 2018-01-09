import React, { Component } from 'react'
import styled from 'styled-components'
import { hiddenStartLabel } from './constants'

const BaseButton = styled.button`
  position: absolute;
  width: 100px;
  height: 22px;
  font-weight: 900;
  color: white;
  z-index: 100;
  left: calc(100% - 100px);
  cursor: pointer;
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

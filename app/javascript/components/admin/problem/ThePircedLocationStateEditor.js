import React from 'react'
import { connect } from 'react-redux'
import styled from 'styled-components'
import { PiercedLocationState } from './constants'

const Li = styled.div`
  margin-bottom: 1px;
`

const Box = styled.div`
  border solid 1px gray;
  padding: 10px;
  margin-bottom: 30px;
`

const Form1 = styled.div`
  position: absolute;
  left: 50px;
`

const Form2 = styled.div`
  position: absolute;
  left: 150px;
`

const Pre = styled.pre`
  font-size: 0.8rem;
  padding-top: 40px;
`

export default function ThePircedLocationStateEditor({ problem, testList }) {
  return (
    <Box>
      <input type="text" value={problem.name} />
      <div>
        {problem.piercedLocationStateList.map(l => (
          <Li key={Math.random()}>
            <input type="hidden" name="pirced-location-id[]" value={l.id} />
            <Form1 className="control">
              <label className="label is-small">出題方式</label>
              <div className="select">
                <select name="labels[]">
                  {Object.keys(PiercedLocationState).map(key => (
                    <option key={key}>{key}</option>
                  ))}
                </select>
              </div>
            </Form1>
            <Form2 className="control">
              <label className="label is-small">対応テスト</label>
              <div className="select">
                <select name="tests[]">
                  {testList.map(key => (
                    <option key={key}>{key}</option>
                  ))}
                </select>
              </div>
            </Form2>
            <Pre>{l.target}</Pre>
          </Li>
        ))}
      </div>
    </Box>
  )
}

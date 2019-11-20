import _ from 'lodash'
import React from 'react'
import { connect } from 'react-redux'
import styled from 'styled-components'

const Hidden = styled.div`
  display: none;
`

const Form = ({ piercedLocation }) => {
  const keys = Object.keys(piercedLocation)
  const loc = piercedLocation
  return (
    <Hidden>
      {keys.map(key =>
        loc[key].map((lines, idx) => (
          <select
            multiple
            key={Math.random()}
            name={`locations[${key}][${idx}][]`}
            defaultValue={lines}>
            {_.map(lines, line => (
              <option key={Math.random()} value={line} />
            ))}
          </select>
        ))
      )}
    </Hidden>
  )
}

export default connect(state => ({ piercedLocation: state.piercedLocation }))(Form)

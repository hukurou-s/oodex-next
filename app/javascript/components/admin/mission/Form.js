import React from 'react'
import { connect } from 'react-redux'
import styled from 'styled-components'

const Hidden = styled.div`
  display: none;
`

const Form = ({ piercedLocation }) => {
  return (
    <Hidden>
      {piercedLocation.map(loc => (
        <select
          multiple
          key={loc.name}
          name={`locations[${loc.name}][]`}
          defaultValue={loc.lines}
        >
          {loc.lines.map(line => (
            <option key={`${loc.name}-${line}`} value={line} />
          ))}
        </select>
      ))}
    </Hidden>
  )
}

export default connect(
  state => ({ piercedLocation: state.piercedLocation })
)(Form)

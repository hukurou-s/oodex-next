import _ from 'lodash'
import React from 'react'

const generateTargetLocation = (source, locations) => {
  const min = _.min(locations) - 3
  const max = _.max(locations) + 3
  return source.split('\n').slice(min, max).join('\n')
}

export default function TheProblemEditor({ piercedLocations, javaMainContents }) {
  const filenames = piercedLocations.map(p => p.file_name)
  const sources = filenames.map(f => _.first(javaMainContents.map(j => j[f]).filter(s => s)))
  const targets = sources.map((s, i) => generateTargetLocation(s, piercedLocations[i].lines))

  return (
    <div>

    </div>
  )
}

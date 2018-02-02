const { createAction } = require('redux-act')

// /admin/missions
export const updatePiercedLocation = createAction('update to pierced location in source code')
export const removePiercedLocation = createAction('remove to pierced location in source code')

// /admin/problems
export const initializeMetaOfProblemEditor = createAction('initialize meta of problem editor')
export const addProblem = createAction('addition problems with state of piercedLocations')

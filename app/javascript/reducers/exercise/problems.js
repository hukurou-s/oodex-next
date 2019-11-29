import immer from 'immer'
import { createReducer } from 'redux-act'
import { initialState } from './initialState'
import * as actions from '../../actions/exercise'

const createProblemList = (problemData, questionData) => {
  return problemData.map(p => ({
    id: p.id,
    name: p.name,
    detail: p.detail,
    questions: questionData.filter(q => q.problem_id === p.id).map(q => ({
      id: q.id,
      name: q.name,
      detail: q.detail
    }))
  }))
}

const problems = createReducer(
  {
    [actions.initializeProblemAndQuestionData]: (state, payload) => {
      console.log(payload)
      const { problemData, questionData } = payload
      const problemList = createProblemList(problemData, questionData)

      const nextState = immer(state, draft => {
        draft.problemsWithTests = payload.problemsWithTests
        draft.questionsWithTests = payload.questionsWithTests
        draft.problemList = problemList
      })
      return nextState
    }
  },
  initialState.problems
)

export default problems

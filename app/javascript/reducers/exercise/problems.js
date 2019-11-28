import immer from 'immer'
import { createReducer } from 'redux-act'
import { initialState } from './initialState'
import * as actions from '../../actions/exercise'

const createProblemList = (problems, questions) => {
  return problems.map(p => ({
    id: p.id,
    name: p.name,
    detail: p.detail,
    questions: questions.filter(q => q.problem_id === p.id).map(q => ({
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
      const { problems, questions } = payload
      const problemList = createProblemList(problems, questions)

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

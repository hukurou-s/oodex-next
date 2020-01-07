import immer from 'immer'
import { createReducer } from 'redux-act'
import { initialState } from './initialState'
import * as actions from '../../actions/exercise'

const createProblemList = (problemData, questionData, score) => {
  return problemData.map(p => ({
    id: p.id,
    name: p.name,
    detail: p.detail,
    questionList: questionData
      .filter(q => q.problem_id === p.id)
      .map(q => ({
        id: q.id,
        name: q.name,
        detail: q.detail,
        perfectScore: score['question'][q.id].perfect,
        currentScore: score['question'][q.id].current
      }))
  }))
}

const problems = createReducer(
  {
    [actions.initializeProblemAndQuestionData]: (state, payload) => {
      const { problemData, questionData, score } = payload
      const problemList = createProblemList(problemData, questionData, score)

      const nextState = immer(state, draft => {
        draft.problemList = problemList
        draft.meta.problemsWithTests = payload.problemsWithTests
        draft.meta.questionsWithTests = payload.questionsWithTests
        draft.meta.javaPiercedContents = payload.javaPiercedContents
      })
      return nextState
    }
  },
  initialState.problems
)

export default problems

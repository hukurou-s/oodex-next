export const initialState = {
  problems: {
    problemList: [
      {
        id: 0,
        name: '',
        detail: '',
        questionList: [
          {
            id: 0,
            name: '',
            detail: '',
            perfectScore: 0,
            currentScore: 0
          }
        ]
      }
    ],
    meta: {
      problemsWithTests: [],
      questionsWithTests: [],
      javaPiercedContents: []
    }
  }
}

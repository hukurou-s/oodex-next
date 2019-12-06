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
            detail: ''
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

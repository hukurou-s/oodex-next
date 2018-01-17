import { takeEvery, put } from 'redux-saga/effects'

function* sampleSaga() {
  yield put(`WIP`)
}

export default function* rootSaga() {
  yield takeEvery(`WIP`, sampleSaga)
}

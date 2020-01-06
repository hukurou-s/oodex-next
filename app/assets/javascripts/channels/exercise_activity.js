const testingCallback = data => {
  switch (data.status) {
    case 'testing':
      window.loader.show('解答をテストしています... 🤔')
      break
    case 'compile error':
      window.loader.fail('コンパイルに失敗しました 😱')
      setTimeout(() => {
        window.loader.hide()
        window.location.reload()
      }, 2000)
      break
    case 'fail':
      window.loader.fail('テストを実行できませんでした 😱')
      break
      setTimeout(() => {
        window.loader.hide()
        window.location.reload()
      }, 2000)
    case 'done':
      window.loader.done('テストが完了しました 😆')
      setTimeout(() => {
        window.loader.hide()
        window.location.reload()
      }, 1000)
      break
  }
}

const exerciseOptions = {
  channel: 'ExerciseActivityChannel'
  //room: 'repo'
}

window.exerciseActivity = () => {
  window.App = window.App || {}
  window.App.cable = ActionCable.createConsumer()

  window.App.repoStream = window.App.cable.subscriptions.create(exerciseOptions, {
    received(data) {
      testingCallback(data)
    }
  })
}

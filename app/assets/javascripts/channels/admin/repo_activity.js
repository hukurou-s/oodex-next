window.repoActivity = () => {
  window.App = window.App || {}
  window.App.cable = ActionCable.createConsumer()

  window.App.repoStream = window.App.cable.subscriptions.create(
    {
      channel: 'Admin::MissionActivityChannel',
      room: 'repo'
    },
    {
      received(data) {
        switch (data.status) {
          case 'uploading':
            window.showPreloader('ダウンロード中です... 🤔')
            break
          case 'fail':
            window.failPreloader('ダウンロードに失敗しました 😱')
            break
          case 'done':
            window.donePreloader('完了しました 😆')
            setTimeout(() => {
              window.location.replace(data.to)
            }, 1000)
            break
        }
      }
    }
  )
}

const RepoActivity = () => {
  window.App = window.App || {}
  App.cable = ActionCable.createConsumer('/admin/cable')

  App.cable.subscriptions.create(
    { channel: 'Repo', room: 'repo creation' },
    {
      received(data) {
        console.log(data)
      }
    }
  )
}

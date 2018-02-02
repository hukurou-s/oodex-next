import 'babel-polyfill'
import WebpackerReact from 'webpacker-react'
import ProblemEditor from '../components/admin/problem'
import MissionEditor from '../components/admin/mission'

window.Turbolinks.start()

WebpackerReact.setup({
  MissionEditor,
  ProblemEditor
})

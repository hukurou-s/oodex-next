import 'babel-polyfill'
import WebpackerReact from 'webpacker-react'
import Exercise from '../components/exercise'

window.Turbolinks.start()

WebpackerReact.setup({
  Exercise
})

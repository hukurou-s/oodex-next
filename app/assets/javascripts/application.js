//= require rails-ujs
//= require turbolinks
//= require nprogress/nprogress
//= require moment/moment
//= require moment-timezone/moment-timezone
//= require rome/dist/rome.min
//= require_tree .

document.addEventListener('turbolinks:click', function() {
  window.NProgress.start()
})
document.addEventListener('turbolinks:render', function() {
  window.NProgress.done()
  window.NProgress.remove()
})

document.addEventListener('turbolinks:request-start', function() {
  window.cursor = window.scrollY
})

document.addEventListener('turbolinks:render', function() {
  window.scroll(0, window.cursor || 0)
})

//= require rails-ujs
//= require turbolinks
//= require nprogress/nprogress
//= require_tree .

document.addEventListener('turbolinks:click', function() {
  NProgress.start()
})
document.addEventListener('turbolinks:render', function() {
  NProgress.done()
  NProgress.remove()
})

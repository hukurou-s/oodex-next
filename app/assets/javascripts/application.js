//= require rails-ujs
//= require turbolinks
//= require nprogress/nprogress
//= require_tree .

$(document).on('turbolinks:click', function() {
  NProgress.start()
})
$(document).on('turbolinks:render', function() {
  NProgress.done()
  NProgress.remove()
})

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

document.addEventListener('turbolinks:load', function() {
  var $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0)
  if ($navbarBurgers.length > 0) {
    $navbarBurgers.forEach(function($el) {
      $el.addEventListener('click', function() {
        var target = $el.dataset.target
        var $target = document.getElementById(target)
        $el.classList.toggle('is-active')
        $target.classList.toggle('is-active')
      })
    })
  }
});

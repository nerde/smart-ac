#= require jquery
#= require rails-ujs
#= require activestorage
#= require turbolinks
#= require popper
#= require bootstrap-sprockets
#= require chartkick
#= require Chart.bundle
#= require moment.min
#= require daterangepicker
#= require_self
#= require_tree .

@onReady = (fn) -> $(document).on 'turbolinks:load', fn

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  $(".comments-link").click (event) ->
    event.preventDefault()
    $('#comments-section').fadeToggle()
    $('#comment_body').focus()
	$('html, body').animate({
		scrollTop: $('#comments-form').offset().top
		}, 'fast')
		
	
	
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#address-text-input').focus()
  $('#address-input-button').click -> 
    address_text = $('#address-text-input').val()
    $('#address-text-input').val('')
    $('.boohoo').after('<div class="col-md-12"><span class="label label-warning">' + address_text + '</span></div>')
    $('#address-text-input').focus()

$(document).on 'keypress', ->
  if event.keyCode is 13
    address_text = $('#address-text-input').val()
    $('#address-text-input').val('')
    $('.boohoo').after('<div class="col-md-12"><span class="label label-warning">' + address_text + '</span></div>')
    $('#address-text-input').focus()
  
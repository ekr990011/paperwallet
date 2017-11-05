# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#address-text-input').focus()
  address_count = $('#front-page-background > div.col-md-12').length
  $('#address-input-button').click ->
    address_text = $('#address-text-input').val()
    valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('.boohoo').after('<div class="col-md-12"><span class="label label-warning">' + address_text + '</span><span class="pull-right glyphicon glyphicon-remove"></span></div>')
      $('#address-text-input').focus()
      address_count = $('#front-page-background > div.col-md-12').length
      console.log(address_count)
$(document).on 'keypress', ->
  if event.keyCode is 13
    address_text = $('#address-text-input').val()
    valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('.boohoo').after('<div class="col-md-12"><span class="label label-warning">' + address_text + '</span><span class="pull-right glyphicon glyphicon-remove"></span></div>')
      $('#address-text-input').focus()

$(document).on 'click', 'span.pull-right.glyphicon.glyphicon-remove', ->
  $(this).parent().remove()
  $('#address-text-input').focus()
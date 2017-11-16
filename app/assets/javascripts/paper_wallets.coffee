# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

before_address_text = '<div class="col-md-12 js-csv"><div class="col-xs-7"><p><span class="label label-warning grid-address">'
after_address_text = '</span></p></div><div class="col-xs-2"><p><span class="label label-info grid-crypto js-btc-check">0.00 BTC</span></p></div><div class="col-xs-2"><p><span class="label label-success grid-fiat js-fiat-check">0.00 USD</span></p></div><div class="col-xs-1"><p><span class="glyphicon glyphicon-remove js-remove"></span></p></div></div>'

$(document).on 'turbolinks:load', ->
  $('#address-text-input').focus()
  address_count = $('#front-page-background > div.col-md-12').length
  $('#address-input-button').click ->
    address_text = $('#address-text-input').val()
    valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('.boohoo').after(before_address_text + address_text + after_address_text)
      $('#address-text-input').focus()
      
$(document).on 'keypress', ->
  if event.keyCode is 13
    address_text = $('#address-text-input').val()
    valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('.boohoo').after(before_address_text + address_text + after_address_text)
      $('#address-text-input').focus()

$(document).on 'click', 'span.glyphicon.glyphicon-remove', ->
  $(this).parentsUntil('#front-page-background').remove()
  $('#address-text-input').focus()
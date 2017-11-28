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
  
  
$(document).on 'click', '.js-check-balance', ->
  addresses_to_check = ''
  $('#front-page-background > div.col-md-12').each ->
    address_to_check = $(this).children('.col-xs-7').text()
    unless addresses_to_check == ''
      addresses_to_check += '|' + address_to_check
    else
      addresses_to_check = address_to_check
    
  addresses_object_response = $.getJSON("https://blockchain.info/balance?active=" + addresses_to_check + "&cors=true", (data, status) ->
    address_object_keys = Object.keys(data)
    address_object_keys_length = address_object_keys.length
    
    # address_btc_total = data[key]["final_balance"]/100000000
    i = 0
    while( i < (address_object_keys_length) )
      console.log( address_object_keys[i] )
      console.log( data[ address_object_keys[i] ]["final_balance"]/100000000 )
      address_btc_total = data[ address_object_keys[i] ]["final_balance"]/100000000
      $('#front-page-background > div.col-md-12.js-csv:eq(' + i + ') > div:nth-child(2) > p > span').text(address_btc_total + ' BTC')
      i += 1
      
)
  
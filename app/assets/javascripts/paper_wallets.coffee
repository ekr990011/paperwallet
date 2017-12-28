# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# <tr>
#             <td>17g8t7pZhTz3J6qUXKKeFMbFG1vMLE7Gb8</td>
#             <td>1.00012345668</td>
#             <td>16,183</td>
#             <td><span class="glyphicon glyphicon-remove"></span></td>
#   	  	  </tr>




$(document).on 'turbolinks:load', ->
  $('#address-text-input').focus()
  address_count = $('#front-page-background > div.col-md-12').length
  $('#address-input-button').click ->
    address_text = $('#address-text-input').val()
    valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('tbody').append('<tr><td>' + address_text + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
      $('#address-text-input').focus()
      
$(document).on 'keypress', ->
  if event.keyCode is 13
    address_text = $('#address-text-input').val()
    valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('tbody').append('<tr><td>' + address_text + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
      $('#address-text-input').focus()

$(document).on 'click', 'span.glyphicon.glyphicon-remove', ->
  $(this).parentsUntil('#front-page-background').remove()
  $('#address-text-input').focus()
  
  
$(document).on 'click', '.js-check-balance', ->
  addresses_to_check = ''
  $('table > tbody > tr').each ->
    address_to_check = $(this).children('td:first').text()
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
      $('table > tbody > tr > td:contains(' + address_object_keys[i] + ')').next().text(address_btc_total + ' BTC')
      i += 1
     
     
     # fiat currency check 
     
     
     
     # btc totals
    crypto_amount_length = $('table > tbody > tr > td:nth-child(2)').length
    
    total_crypto_amount = 0
    i = 0
    while i < crypto_amount_length
      total_crypto_amount += parseFloat($('table > tbody > tr > td:nth-child(2)').eq(i).text())
      i += 1
    
    $('#crypto-total-addresses').text(crypto_amount_length)
    $('#crypto-total-amount').text(total_crypto_amount)
     
)
  
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
      
$(document).on 'click', '.info-box', ->
  $('#info-button-panel').toggle()

$(document).on 'click', 'crypto-list', ->
  $('crypto-list-dropdown').toggle()    
  
$(document).on 'click', 'span.glyphicon.glyphicon-remove', ->
  $(this).parentsUntil('tbody').remove()
  $('#address-text-input').focus()
  monetaryCheck()
  

fiat_current_price = 0
$(document).on 'click', '.js-check-balance', ->
  addresses_to_check = ''
  $('table > tbody > tr').each ->
    address_to_check = $(this).children('td:first').text()
    unless addresses_to_check == ''
      addresses_to_check += '|' + address_to_check
    else
      addresses_to_check = address_to_check
      
  # fiat currency check 
  $.getJSON("https://api.coinmarketcap.com/v1/ticker/bitcoin/", (result) ->
    fiat_current_price = result[0].price_usd
  
    # crypto check  
    addresses_object_response = $.getJSON("https://blockchain.info/balance?active=" + addresses_to_check + "&cors=true", (data, status) ->
      address_object_keys = Object.keys(data)
      address_object_keys_length = address_object_keys.length
      
      # address_btc_total = data[key]["final_balance"]/100000000
      i = 0
      while( i < (address_object_keys_length) )
        # console.log( address_object_keys[i] )
        # console.log( data[ address_object_keys[i] ]["final_balance"]/100000000 )
        address_btc_total = data[ address_object_keys[i] ]["final_balance"]/100000000
        
        #crypto & fiat into address tr seperated by .next()
        $('table > tbody > tr > td:contains(' + address_object_keys[i] + ')').next().text(address_btc_total).next().text((fiat_current_price * address_btc_total))
        i += 1
        
     # btc totals  && fiat totals
      monetaryCheck()
      return 0
    )
  )     
       
       
monetaryCheck = () ->
  crypto_amount_length = $('table > tbody > tr > td:nth-child(2)').length
  total_crypto_amount = 0
  total_fiat_amount = 0
  
  # fix $ and , from messing up totals
  $('table > tbody > tr > td:nth-child(3)').each ->
  	totals_removed_special_characters = $(this).text().replace('$', '').replace(',', '')
	  $(this).text(totals_removed_special_characters)
  
  i = 0
  while i < crypto_amount_length
    total_crypto_amount += parseFloat($('table > tbody > tr > td:nth-child(2)').eq(i).text())
    
    total_fiat_amount += parseFloat($('table > tbody > tr > td:nth-child(3)').eq(i).text())
    console.log total_fiat_amount
    i += 1
  
  $('#crypto-total-addresses').text(crypto_amount_length)
  $('#crypto-total-amount').text(total_crypto_amount)
  
  $('#fiat-total-amount').text(total_fiat_amount).addCommas()
  $('#fiat-total-amount').prepend('$')
  $('#fiat-total-amount').append('  |  $' + addCommas(fiat_current_price))
  
  #addCommas in digits_function.js
  $('table > tbody > tr > td:nth-child(3)').addCommas()
  $('table > tbody > tr > td:nth-child(3)').prepend('$')

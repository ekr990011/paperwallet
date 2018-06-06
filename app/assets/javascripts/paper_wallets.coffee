# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  makeQrcode()
  $('#address-text-input').focus()
  $('#address-input-button').click ->
    address_text = $('#address-text-input').val().trim()
    valid = validatePublicAddress(address_text)
    # valid = WAValidator.validate(address_text, 'BTC')
    i = 1
    $('table > tbody > tr').each ->
      console.log($('table > tbody > tr:nth-child(' + i + ') > td').text())
      if address_text == $('table > tbody > tr:nth-child(' + i + ') > td').text()
        valid = false
      i++ 
        
    if valid
      $('#address-text-input').val('')
      $('tbody').append('<tr><td>' + address_text + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
      $('#address-text-input').focus()
    else
      alert('Invalid Address, Please check for invalid or dupilcate address.')
      
$(document).on 'keypress', ->
  makeQrcode()
  if event.keyCode is 13
    address_text = $('#address-text-input').val().trim()
    valid = validatePublicAddress(address_text)
    # valid = WAValidator.validate(address_text, 'BTC')
    if valid
      $('#address-text-input').val('')
      $('tbody').append('<tr><td>' + address_text + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
      $('#address-text-input').focus()
    else
      alert('Invalid Address, Please check for invalid or dupilcate address.')
      
$(document).on 'click', '.info-box', ->
  $('#info-button-panel').toggle()

$(document).on 'click', 'crypto-list', ->
  $('crypto-list-dropdown').toggle()    
  
$(document).on 'click', 'span.glyphicon.glyphicon-remove', ->
  $(this).parentsUntil('tbody').remove()
  $('#address-text-input').focus()
  monetaryCheck()
  

fiat_current_price = 0
addresses_to_check = ''
$(document).on 'click', '.js-check-balance', ->
  # fiat currency check 
  crypto_coinmarketcap = $('.crypto-list').text().trim().toLowerCase()
  $.getJSON("https://api.coinmarketcap.com/v1/ticker/" + crypto_coinmarketcap + "/", (result) ->
    fiat_current_price = result[0].price_usd
  
    # crypto check
    crypto = $('.crypto-symbol-js').text().slice(0, 3).toLowerCase()
    if crypto == 'btc'
      bitcoinCrypto()
    else
      cryptoAddressAmount()
      
    return 0
  )
  
# crypto address balances
bitcoinCrypto = () ->
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
      # console.log( address_object_keys[i] )
      # console.log( data[ address_object_keys[i] ]["final_balance"]/100000000 )
      address_btc_total = data[ address_object_keys[i] ]["final_balance"]/100000000
      
      #crypto & fiat into address tr seperated by .next()
      $('table > tbody > tr > td:contains(' + address_object_keys[i] + ')').next().text(address_btc_total).next().text((fiat_current_price * address_btc_total).toFixed(2))
      i += 1
      
   # btc totals  && fiat totals
    monetaryCheck()
    return 0
  )
  
cryptoAddressAmount = () ->
  crypto = $('.crypto-symbol-js').text().slice(0, 3).toLowerCase()
  addresses_to_check = ''
  $('table > tbody > tr').each ->
    address_to_check = $(this).children('td:first').text()
    unless addresses_to_check == ''
      addresses_to_check += ',' + address_to_check
    else
      addresses_to_check = address_to_check
  
  # crypto = $('.crypto-symbol-js').text().slice(0, 3).toLowerCase()
  # https://multiexplorer.com/api/address_balance/private5?addresses=16DsrC7mUZG7ZYJR1T6rJo16aogKicwAi9,1MgGUeGKTWjTGM8FYmVBbYhoPznZvos5cg,1NiNja1bUmhSoTXozBRBEtR8LeF9TGbZBN&currency=btc
  addresses_object_response = $.get("https://multiexplorer.com/api/address_balance/private5?addresses=" + addresses_to_check + "&currency=" + crypto , (data, status) ->
    address_object_keys = Object.keys(data['balance'])
    address_object_keys_length = address_object_keys.length
    
    # console.log(address_object_keys_length)
    i = 0
    while( i < (address_object_keys_length) )
      # console.log(address_object_keys[i] )
      unless address_object_keys[i] == 'total_balance'
        # console.log(data['balance'][address_object_keys[i]])
        address_crypto_total = data['balance'][address_object_keys[i]]
        #crypto & fiat into address tr seperated by .next()
        
        $('table > tbody > tr > td:contains(' + address_object_keys[i] + ')').next().text(address_crypto_total).next().text((fiat_current_price * address_crypto_total).toFixed(2))
      i += 1
      
   # btc totals  && fiat totals
    monetaryCheck()
    return 0
  )
  
monetaryCheck = () ->
  crypto_amount_length = $('table > tbody > tr > td:nth-child(2)').length
  total_crypto_amount = 0
  total_fiat_amount = 0
  
  # fix $ and , from messing up totals
  regex_commas = new RegExp(/\,/, 'g')
  regex_dollar_sign = new RegExp(/\$/, 'g')
  $('table > tbody > tr > td:nth-child(3)').each ->
  	totals_removed_special_characters = $(this).text().replace(regex_dollar_sign, '').replace(regex_commas, '')
	  $(this).text(totals_removed_special_characters)
  
  i = 0
  while i < crypto_amount_length
    total_crypto_amount += parseFloat($('table > tbody > tr > td:nth-child(2)').eq(i).text())
    total_fiat_amount += parseFloat($('table > tbody > tr > td:nth-child(3)').eq(i).text())
    # console.log total_fiat_amount
    i += 1
  
  $('#crypto-total-addresses').text(crypto_amount_length)
  $('#crypto-total-amount').text(total_crypto_amount)
  
  #addCommas in digits_function.js
  $('#fiat-total-amount').text(total_fiat_amount).addCommas()
  $('#fiat-total-amount').prepend('$')
  $('#fiat-total-amount').append('  |  $' + addCommas(fiat_current_price))
  
  $('table > tbody > tr > td:nth-child(3)').addCommas()
  $('table > tbody > tr > td:nth-child(3)').prepend('$')


validatePublicAddress = (address_text) ->
  crypto_to_check = $('.crypto-symbol-js').text().slice(0, 3)
  WAValidator.validate(address_text, crypto_to_check)
  
 
makeQrcode = () ->
  qrcode = new QRCode(document.getElementById("donation-img"), {
    width: 1320,
    height: 1320
    })
  elText = document.getElementById("donation-address").innerText
  console.log(elText)
  qrcode.makeCode(elText)


  
# <script type="text/javascript">
# var qrcode = new QRCode(document.getElementById("qrcode"), {
# 	width : 100,
# 	height : 100
# });

# function makeCode () {		
# 	var elText = document.getElementById("text");
	
# 	if (!elText.value) {
# 		alert("Input a text");
# 		elText.focus();
# 		return;
# 	}
	
# 	qrcode.makeCode(elText.value);
# }

# makeCode();

# $("#text").
# 	on("blur", function () {
# 		makeCode();
# 	}).
# 	on("keydown", function (e) {
# 		if (e.keyCode == 13) {
# 			makeCode();
# 		}
# 	});
# </script>
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#donation-img').hide()
  makeQrcode(document.getElementById("donation-address").innerText, document.getElementById("donation-img"))
  $('#donation-img').fadeIn(1500)
  $('#address-text-input').focus()
  $('#address-input-button').click ->
    address_text = $('#address-text-input').val().trim()
    valid = validatePublicAddress(address_text)
    duplicate = false
    i = 1
    $('table > tbody > tr').each ->
      if address_text == $('table > tbody > tr:nth-child(' + i + ') > td').text()
        valid = false
        duplicate = true
      i++ 
        
    if valid
      $('#address-text-input').val('')
      $('tbody').append('<tr><td class="cryptoAddress">' + address_text + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
      $('#address-text-input').focus()
    else if duplicate
      $('.header').append('<div class="alert alert-warning alert-duplicate">Duplicate Address. Please Check!</div>')
      $('.alert-duplicate').fadeOut(8000, -> $s(this).remove() )
    else
      $('.header').append('<div class="alert alert-warning alert-invalid">Invalid Address, Please Check Input!</div>')
      $('.alert-invalid').fadeOut(8000, -> $(this).remove() )
      
$(document).on 'keypress', (event) ->
  if event.keyCode is 13
    address_text = $('#address-text-input').val().trim()
    valid = validatePublicAddress(address_text)
    duplicate = false
    i = 1
    $('table > tbody > tr').each ->
      if address_text == $('table > tbody > tr:nth-child(' + i + ') > td').text()
        valid = false
        duplicate = true
      i++ 
    
    if valid
      $('#address-text-input').val('')
      $('tbody').append('<tr><td class="cryptoAddress">' + address_text + '</td><td></td><td></td><td><span class="glyphicon glyphicon-remove"></span></td></tr>')
      $('#address-text-input').focus()
    else if duplicate
      $('.header').append('<div class="alert alert-warning alert-duplicate">Duplicate Address. Please Check!</div>')
      $('.alert-duplicate').fadeOut(8000, -> $(this).remove() )
    else
      $('.header').append('<div class="alert alert-warning alert-invalid">Invalid Address. Please Check Input!</div>')
      $('.alert-invalid').fadeOut(8000, -> $(this).remove() )
      
$(document).on 'click', '.info-box', ->
  $('#info-button-panel').toggle()

$(document).on 'click', 'crypto-list', ->
  $('crypto-list-dropdown').toggle()    
  
$(document).on 'click', 'span.glyphicon.glyphicon-remove', ->
  $(this).parentsUntil('tbody').remove()
  $('#address-text-input').focus()
  monetaryCheck()
  
$(document).on 'click', '.copy-address', ->
  copy_text = $('#donation-address').text().trim()
  clipboard.writeText(copy_text)
  $('.header').append('<span class="alert alert-warning alert-copy">Copied to Clipboard<span>')
  $('#address-text-input').focus()
  $('.alert-copy').fadeOut(4500, -> $(this).remove() )

$(document).on 'click', '.cryptoAddress', ->
  $('#modal-qrcode').empty()
  $('.modal-title').empty()
  $('.modal').modal('show')
  $('.modal-title').text($(this).text())
  $('.modal-title').append('<br><span class="glyphicon glyphicon-copy"></span>')
  makeQrcode($(this).context.innerText, document.getElementById('modal-qrcode'))
  
$(document).on 'click', '.modal-title > span.glyphicon-copy', ->
  copy_text = $('.modal-title').text()
  clipboard.writeText(copy_text)
  $('.modal-title').append('<div class="alert alert-warning">Copied to Clipboard</div>')
  $('.modal-title > .alert-warning').fadeOut(4500, -> $(this).remove() )
  
$(document).on 'click', '.close', ->
  $('.modal').attr('style', '')
  
fiat_current_price = 0
addresses_to_check = ''
$(document).on 'click', '.js-check-balance', ->
  # fiat currency check 
  crypto_coinmarketcap = $('.crypto-list > div').text().trim().toLowerCase()
  $.getJSON("https://api.coinmarketcap.com/v2/ticker/" + crypto_coinmarketcap + "/", (result) ->
    fiat_current_price = result.data.quotes.USD.price
  
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
  crypto = $('.crypto-symbol-js').text().replace(' : ', '').toLowerCase()
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
  crypto_symbol = $('.crypto-symbol-js').text().slice(0, 3)
  $('#fiat-current-price').text('Current ' + crypto_symbol + ' / USD : $' + addCommas(fiat_current_price.toFixed(2)))
  
  $('table > tbody > tr > td:nth-child(3)').addCommas()
  $('table > tbody > tr > td:nth-child(3)').prepend('$')


validatePublicAddress = (address_text) ->
  crypto_to_check = $('.crypto-symbol-js').text().replace(' : ', '')
  WAValidator.validate(address_text, crypto_to_check)
  

makeQrcode = (inputText, inputLocation) ->
  qrcode = new QRCode(inputLocation, {
    width: 1320,
    height: 1320, 
    })
  qrcode.makeCode(inputText)
  $('.donation-img > img').addClass('img-responsive')
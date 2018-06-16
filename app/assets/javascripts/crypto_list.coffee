# Jquery for the crypto-list items on the page and changing titles/validation/denominations
crypto_list_array = [{
            name: 'bitcoin',
            symbol: 'btc',
            donationAddress: '17g8t7pZhTz3J6qUXKKeFMbFG1vMLE7Gb8',
            addressTypes: {prod: ['00', '05'], testnet: ['6f', 'c4']}
        },{
            name: 'litecoin',
            symbol: 'ltc',
            donationAddress: 'LY7bmtNotjgfsQ1q8dQLgrYeyNmDCyhfvF',
            addressTypes: {prod: ['30', '05'], testnet: ['6f', 'c4']}
        },{
            name: 'peercoin',
            symbol: 'ppc',
            donationAddress: 'PQinj6iaWhbWTNrJFTAS4EkmzwoJAmzmxP',
            addressTypes: {prod: ['37', '75'], testnet: ['6f', 'c4']}
        },{
            name: 'namecoin',
            symbol: 'nmc',
            donationAddress: 'NEqfKtDtGnEBXae5k7T1fivfXbA5j5oBHk',
            addressTypes: {prod: ['34'], testnet: []}
        }]
                    
$(document).on 'turbolinks:load', ->
  i = 0
  while i < crypto_list_array.length
    unless i == 0  
      $('.crypto-list-dropdown').append('<li><a href="#">' + crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1) + '</a><span class="hidden">'+ crypto_list_array[i].symbol + '</span></li>')
    i += 1
    
$(document).on 'click', '.crypto-list-dropdown > li', (e) ->
  e.preventDefault()
  old_crypto_item = $('.crypto-list').text().trim()
  
  $('.crypto-list').html($(this).find('a').text() + ' <span class="caret"></span>')
  $('.crypto-symbol-js').text($(this).find('span').text().toUpperCase() + " : ")
  $('.crypto-symbol-js').append('<span id="crypto-total-amount"></span>')
  $(this).remove()
  $('tbody').html('')
  $('#crypto-total-addresses').text('')
  $('#crypto-total-amount').text('')
  $('#fiat-total-amount').text('')
  
  i = 0
  for i  in [0...crypto_list_array.length]
    if ($(this).find('a').text().toLowerCase()) == (crypto_list_array[i].name)
      # console.log(crypto_list_array[i].donationAddress)
      $('.donation-address').text(crypto_list_array[i].donationAddress)
      $('.donation-address').append('<span class="glyphicon glyphicon-copy"></span>')
    i += 1
  makeQrcode()
    
    
  i = 0
  for i  in [0...crypto_list_array.length]
    crypto_list_array_item = crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1)
    if crypto_list_array_item == old_crypto_item
      $('.crypto-list-dropdown').prepend('<li><a href="#">' + crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1) + '</a><span class="hidden">'+ crypto_list_array[i].symbol + '</span></li>')
  
  
makeQrcode = () ->
  if $('.donation-img > img')
    # console.log('not null')
    $('.donation-img > img').remove()
    $('.donation-img > canvas').remove()
  qrcode = new QRCode(document.getElementById("donation-img"), {
    width: 110,
    height: 110
    })
  elText = document.getElementById("donation-address").innerText

  qrcode.makeCode(elText)
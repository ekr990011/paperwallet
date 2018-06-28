# JQuery for the crypto-list items on the page and changing titles/validation/denominations
crypto_list_array = [{
            name: 'bitcoin',
            symbol: 'btc',
            donationAddress: '17g8t7pZhTz3J6qUXKKeFMbFG1vMLE7Gb8',
            id: 1
        },{
            name: 'ethereum',
            symbol: 'eth',
            id: 1027
        },{
            name: 'ripple',
            symbol: 'xrp',
            id: 52
        },{
            name: 'bitcoincash',
            symbol: 'bch',
            id: 1831
        },{
            name: 'litecoin',
            symbol: 'ltc',
            donationAddress: 'LY7bmtNotjgfsQ1q8dQLgrYeyNmDCyhfvF',
            id: 2
        },{
            name: 'peercoin',
            symbol: 'ppc',
            donationAddress: 'PQinj6iaWhbWTNrJFTAS4EkmzwoJAmzmxP',
            id: 5
        },{
            name: 'namecoin',
            symbol: 'nmc',
            donationAddress: 'NEqfKtDtGnEBXae5k7T1fivfXbA5j5oBHk',
            id: 3
        },{
            name: 'dogecoin',
            symbol: 'doge',
            id: 74
        },{
            name: 'ethereumclassic',
            symbol: 'etc',
            id: 1321
        },{
            name: 'vertcoin',
            symbol: 'vtc',
            id: 99
        },{
            name: 'bitcoingold',
            symbol: 'btg',
            id: 2083
        },{
            name: 'dash',
            symbol: 'dash',
            id: 131
        },{
            name: 'neo',
            symbol: 'neo',
            id: 1376
        },{
            name: 'neogas',
            symbol: 'gas',
            id: 1785
        },{
            name: 'qtum',
            symbol: 'qtum',
            id: 1684
        },{
            name: 'komodo',
            symbol: 'kmd',
            id: 1521
        },{
            name: 'bitcoinz',
            symbol: 'btcz',
            id: 2041
        },{
            name: 'bitcoinprivate',
            symbol: 'btcp',
            id: 2575
        },{
            name: 'zencash',
            symbol: 'zen',
            id: 1698
        },{
            name: 'zcash',
            symbol: 'zec',
            id: 1437
        },{
            name: 'zclassic',
            symbol: 'zcl',
            id: 1447
        },{
            name: 'decred',
            symbol: 'dcr',
            id: 1168
        },{
            name: 'digibyte',
            symbol: 'dgb',
            id: 109
        }]
                    
$(document).on 'turbolinks:load', ->
  i = 0
  while i < crypto_list_array.length
    unless i == 0  
      $('.crypto-list-dropdown').append('<li><a href="#">' + crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1) + '</a><span class="hidden">'+ crypto_list_array[i].symbol + '</span><div class="hidden">'+ crypto_list_array[i].id + '</div></li>')
    i += 1
    
$(document).on 'click', '.crypto-list-dropdown > li', (e) ->
  e.preventDefault()
  old_crypto_item = $('.crypto-list').text()
  old_crypto_item_replace = $('.crypto-list > div').text()
  old_crypto_item = old_crypto_item.replace(old_crypto_item_replace, "").trim()
  
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
      $('.crypto-list').html($(this).find('a').text() + ' <span class="caret"></span>' + '<div class="hidden">' + crypto_list_array[i].id + '</div>')
      $('.donation-address').text(crypto_list_array[i].donationAddress)
    crypto_list_array_item = crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1)
    if crypto_list_array_item == old_crypto_item
      $('.crypto-list-dropdown').prepend('<li><a href="#">' + crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1) + '</a><span class="hidden">'+ crypto_list_array[i].symbol + '</span>' + '<div class="hidden">' + crypto_list_array[i].id + '</div>' + '</li>')
    i += 1
    
  makeQrcode()
  
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
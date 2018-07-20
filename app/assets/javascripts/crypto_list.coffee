# JQuery for the crypto-list items on the page and changing titles/validation/denominations
crypto_list_array = [{
            name: 'bitcoin',
            symbol: 'btc',
            donationAddress: '1337ipJbP7U9mi9cdLngL3g5Napum7tWzM',
            id: 1
        },{
            name: 'ethereum',
            symbol: 'eth',
            donationAddress: '0x94483b123b422d2Ab61fC459118667513956144E',
            id: 1027
        },{
            name: 'ripple',
            symbol: 'xrp',
            donationAddress: 'rJ8o2N7MajfpCVDJHyjWcu7yo3knvHHXfN',
            id: 52
        },{
            name: 'bitcoincash',
            symbol: 'bch',
            donationAddress: '1GDLQvcZY8TS56gf6X8Hm94B8wRkbtV438',
            id: 1831
        },{
            name: 'litecoin',
            symbol: 'ltc',
            donationAddress: 'LWcXUB6ny88tK49TK1V6KprE5oDcJ1zJhx',
            id: 2
        },{
            name: 'peercoin',
            symbol: 'ppc',
            donationAddress: 'PMWKyz4Sr8nKZnjABsWKnxJHCnjKo4garm',
            id: 5
        },{
            name: 'namecoin',
            symbol: 'nmc',
            donationAddress: 'NKX2XRAnucmc8RBTV9oZo8kgx7NP6K52JV',
            id: 3
        },{
            name: 'dogecoin',
            symbol: 'doge',
            donationAddress: 'DND5TbT834xsjBre1c6pREJYWMDWKAL1rc',
            id: 74
        },{
            name: 'ethereumclassic',
            symbol: 'etc',
            donationAddress: 'Ethereum CLassic Paper Wallet Checker!',
            id: 1321
        },{
            name: 'vertcoin',
            symbol: 'vtc',
            donationAddress: 'VhuhgKpVwgqyuNCsJpEjcWxxKyP9rm9Aod',
            id: 99
        },{
            name: 'bitcoingold',
            symbol: 'btg',
            donationAddress: 'GMbBJi6x6osdKnCnQUZqUWgD3fGztzik1h',
            id: 2083
        },{
            name: 'dash',
            symbol: 'dash',
            donationAddress: 'XckPoTubxQ8PbY9VAYCnSZarpsq6BFNUHA',
            id: 131
        },{
            name: 'neo',
            symbol: 'neo',
            donationAddress: 'Neo Paper Wallet Checker!',
            id: 1376
        },{
            name: 'neogas',
            symbol: 'gas',
            donationAddress: 'Neo Gas Paper Wallet Checker!',
            id: 1785
        },{
            name: 'qtum',
            symbol: 'qtum',
            donationAddress: 'Qtum Paper Wallet Checker!',
            id: 1684
        },{
            name: 'komodo',
            symbol: 'kmd',
            donationAddress: 'Komodo Paper Wallet Checker!',
            id: 1521
        },{
            name: 'bitcoinz',
            symbol: 'btcz',
            donationAddress: 'Bitcoinz Paper Wallet Checker!',
            id: 2041
        },{
            name: 'bitcoinprivate',
            symbol: 'btcp',
            donationAddress: 'zkWoKvGLVc3Te6cjrCCcTGcihvuCrJqkpFuD669Vk8fjbFeCM2q6TfYvWXeg23MuQBkGEWn8ppWRA7FQDp2cLmkBPURw439',
            id: 2575
        },{
            name: 'zencash',
            symbol: 'zen',
            donationAddress: 'Zen Paper Wallet Checker!',
            id: 1698
        },{
            name: 'zcash',
            symbol: 'zec',
            donationAddress: 't1d29PNHtTJHHE4jMeLJFrmRcHJNhyYxZZC',
            id: 1437
        },{
            name: 'zclassic',
            symbol: 'zcl',
            donationAddress: 'ZClassic Paper Wallet Checker!',
            id: 1447
        },{
            name: 'decred',
            symbol: 'dcr',
            donationAddress: 'Decred Paper Wallet Checker!',
            id: 1168
        },{
            name: 'digibyte',
            symbol: 'dgb',
            donationAddress: 'DKkftwDYUQpMZCcDmcgtbLnCk5sf1qV9Hi',
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
      $('.donation-address').append(' <span class="glyphicon glyphicon-copy"></span>')
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
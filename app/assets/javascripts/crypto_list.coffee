# Jquery for the crypto-list items on the page and changing titles/validation/denominations
crypto_list_array = [{
            name: 'bitcoin',
            symbol: 'btc',
            addressTypes: {prod: ['00', '05'], testnet: ['6f', 'c4']}
        },{
            name: 'litecoin',
            symbol: 'ltc',
            addressTypes: {prod: ['30', '05'], testnet: ['6f', 'c4']}
        },{
            name: 'peercoin',
            symbol: 'ppc',
            addressTypes: {prod: ['37', '75'], testnet: ['6f', 'c4']}
        },{
            name: 'freicoin',
            symbol: 'frc',
            addressTypes: {prod: ['00', '05'], testnet: ['6f', 'c4']}
        },{
            name: 'megacoin',
            symbol: 'mec',
            addressTypes: {prod: ['32', '05'], testnet: ['6f', 'c4']}
        },{
            name: 'namecoin',
            symbol: 'nmc',
            addressTypes: {prod: ['34'], testnet: []}
        },{
            name: 'biocoin',
            symbol: 'bio',
            addressTypes: {prod: ['19', '14'], testnet: ['6f', 'c4']}
        }]
                    
$(document).on 'turbolinks:load', ->
  i = 0
  while i < crypto_list_array.length
    unless i == 0  
      $('.crypto-list-dropdown').append('<li><a href="#">' + crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1) + '</a><span class="hidden">'+ crypto_list_array[i].symbol + '</span></li>')
    i += 1
    
$(document).on 'click', '.crypto-list-dropdown > li', (e) ->
  old_crypto_item = $('.crypto-list').text().trim()
  
  $('.crypto-list').html($(this).find('a').text() + ' <span class="caret"></span>')
  $('.crypto-symbol-js').text($(this).find('span').text().toUpperCase() + " : ")
  $('.crypto-symbol-js').append('<span id="crypto-total-amount"></span>')
  $(this).remove()
  e.preventDefault()
  
  i = 0
  for i  in [0...crypto_list_array.length]
    crypto_list_array_item = crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1)
    if crypto_list_array_item == old_crypto_item
      $('.crypto-list-dropdown').prepend('<li><a href="#">' + crypto_list_array[i].name.charAt(0).toUpperCase() + crypto_list_array[i].name.slice(1) + '</a><span class="hidden">'+ crypto_list_array[i].symbol + '</span></li>')
  
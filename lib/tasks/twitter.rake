require 'dotenv/tasks'


namespace :twitter do
  task :promote do
    
  require 'twitter'
  require 'net/http'
  require 'json'
 
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  end
  
  
  cryptoIdArray = [ 1, 2, 3, 1831, 52, 2083, 2575, 2041, 1027, 1321, 1437, 131, 1376, 1785, 1521]
  
# The cryptoIdArray contains the Coinmarketcap Ids for the cryptocurrencies  
# cryptoIdArray.each do |id|
    id = cryptoIdArray[rand(15)]
    puts "id is #{id}"
    url = "https://api.coinmarketcap.com/v2/ticker/#{id}/?structure=array"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    exchange_data = JSON.parse(response)
    
    puts exchange_data
    
    name = exchange_data["data"][0]["name"]
    symbol = exchange_data["data"][0]["symbol"]
    price = exchange_data["data"][0]["quotes"]["USD"]["price"]
    percentChange = exchange_data["data"][0]["quotes"]["USD"]["percent_change_24h"]
    if percentChange > 0
      direction = "UP"
    else
      direction = "DOWN"
    end
    tweet = "#{name} price #{price}, #{direction} #{percentChange} percent in 24hrs.  Check your #{symbol} paperwallets quickly and securely at www.12345.com" 
    puts tweet
 # end 
#  client.update("testing 123")
    
    
    
  end
end



require 'dotenv/tasks'


namespace :twitter do
  task :promote do
    p ENV["TWITTER"]
    
  require 'twitter'
  require 'net/http'
  require 'json'
 
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  end
  
  
  url = "https://api.coinmarketcap.com/v2/ticker/1/?structure=array"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  exchange_data = JSON.parse(response)
  puts exchange_data[0]
    
#  client.update("testing 123")
    
    
    
  end
end


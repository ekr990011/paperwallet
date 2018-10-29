if Rails.env == "development" 
  require 'dotenv/tasks'
end

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
  
  
  cryptoIdArray = [ 1, 2, 3, 1831, 52, 2083, 2575, 2041, 1027, 1321, 1437, 131, 1376, 1785, 1521, 5, 74, 1698, 1684, 1447, 99]

# The cryptoIdArray contains the Coinmarketcap Ids for the cryptocurrencies  
#   cryptoIdArray.each do |id|
    id = cryptoIdArray[rand(21)]
    puts "id is #{id}"
    url = "https://api.coinmarketcap.com/v2/ticker/#{id}/?structure=array"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    exchange_data = JSON.parse(response)
    name = exchange_data["data"][0]["name"]
    symbol = exchange_data["data"][0]["symbol"]
    price = exchange_data["data"][0]["quotes"]["USD"]["price"]
    percentChange = exchange_data["data"][0]["quotes"]["USD"]["percent_change_24h"]
    if percentChange > 0
      direction = "UP"
    else
      direction = "DOWN"
    end
    tweet = "#{name} price #{price}, #{direction} #{percentChange} percent in 24hrs.  Check your #{symbol} paperwallets quickly and securely at h" 
    puts tweet

#  end 
  # client.update(tweet)
  
  # Youtube tweet
  
  
  API_Key = 'AIzaSyBQAeRsVuWubChoccGqJDDdlXErOnI2YEo'
  baseUrl = 'https://www.googleapis.com/youtube/v3/'
  publishedAfter = ((DateTime.now.getutc - 1.hours).to_datetime.rfc3339).slice(0..16) + '00Z'
  puts "publishedAfter: #{publishedAfter}"
      
  url = "#{baseUrl}search?part=snippet&q=bitcoin+blockchain&type=video&maxResults=25&publishedAfter=#{publishedAfter}&key=#{API_Key}"

  puts url
      
  uri = URI(url)
  response = Net::HTTP.get(uri)
  youTube_data = JSON.parse(response)
  
  ytTitle = youTube_data["items"][0]["snippet"]["title"]
  
  # number = youTube_data["items"].length
  # puts "count #{number}"
  # 
  # i = 0
  # while i < number
  #   ytTitle = youTube_data["items"][i]["snippet"]["title"]
  #   ytChannelId = youTube_data["items"][i]["snippet"]["channelId"]
  #   ytVideoId =  youTube_data["items"][i]["id"]["videoId"]
  #   i += 1
  # end
  
  youTweet = "Latest Crypto News from PaperWallet Checker: #{ytTitle} #{url}"
  puts youTweet
  
  client.update(youTweet)
    
    
  end
end



require 'dotenv/tasks'

namespace :cryptopanic do
  desc "CryptoPanic"
  # task promote: :dotenv do
  task :promote do
    
    cryptoToken = ENV['API_AUTH_TOKEN']

  
  require 'net/http'
  require 'json'
  
  
  baseUrl = 'https://cryptopanic.com/api/posts/'
  
  
  puts cryptoToken
  
  url = "#{baseUrl}?auth_token=#{cryptoToken}&currencies=BTC,ETH,BCH&public=true"
  
  puts url
      
  uri = URI(url)
  response = Net::HTTP.get(uri)
  cryptoPanic_data = JSON.parse(response)
  
  # puts cryptoPanic_data
  
  number = cryptoPanic_data["results"].length
  # puts "count #{number}"
  
  puts cryptoPanic_data["results"][0]
  
  title = cryptoPanic_data["results"][0]["title"]
  link = cryptoPanic_data["results"][0]["url"]
  
  puts " "
  puts title
  puts link
  
  end
end
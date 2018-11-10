
namespace :youtube do
  desc "Youtube"
  task :promote do
  
  require 'net/http'
  require 'json'
  
  
  API_Key = 'AIzaSyBQAeRsVuWubChoccGqJDDdlXErOnI2YEo'
  baseUrl = 'https://www.googleapis.com/youtube/v3/'
  publishedAfter = ((DateTime.now.getutc - 1.hours).to_datetime.rfc3339).slice(0..16) + '00Z'
  puts "publishedAfter: #{publishedAfter}"
      
  url = "#{baseUrl}search?part=snippet&q=bitcoin+blockchain&type=video&maxResults=25&publishedAfter=#{publishedAfter}&key=#{API_Key}"

  puts url
      
  uri = URI(url)
  response = Net::HTTP.get(uri)
  youTube_data = JSON.parse(response)
  
  number = youTube_data["items"].length
  puts "count #{number}"
  
  i = 0
  while i < number
    ytTitle = youTube_data["items"][i]["snippet"]["title"]
    ytChannelId = youTube_data["items"][i]["snippet"]["channelId"]
    ytVideoId =  youTube_data["items"][i]["id"]["videoId"]
    
    # puts youTube_data
    
    # puts "title: #{ytTitle}"
    # puts "ChannelId: #{ytChannelId}"
    # puts "VidoeID: #{ytVideoId}"
    # puts ""
    # 
    i += 1
  end
  
  end
end 
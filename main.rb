require 'sinatra'
require 'sinatra/reloader' if development?
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

get "/" do
    @title = "Joel Patterson's Portfolio"
    @description = "This site showcases all of the awesome things that Joel Patterson has done."
    
    require "sinatra"
    require "twitter"
    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "X5tRK3AK2iWMSf542zMpXM4DC"
    config.consumer_secret     = "1tGmuinA6KJqVKuWQwK7QNraZZKlsPdnxxzD87MEuTgoswq45j"
    config.access_token        = "1875505560-kZNbBGn5OowWAA8yRfqiBh75O1FHbqz5TfHckhy"
    config.access_token_secret = "0JU47mOnOw4VFx4pNZHallL2oyYTDbTXCtWZnUaaq8pPk"
end
    
    @search_results = client.search("Affordable Care Act", result_type: "most retweeted").take(10).collect do |tweet|
    #"{tweet.user.screen_name}: {tweet.text}"
        tweet
        
    end
       
    require "sinatra"
    require "instagram"

    #enable :sessions

    CALLBACK_URL = "http://localhost:4567/oauth/callback"

    Instagram.configure do |config|
        config.client_id = "e8cf79e549a0447d9ebc7947432023ae"
        config.client_secret = "debb5ed5acbe48d3bb034fee1b2633b2"
        # For secured endpoints only
        #config.client_ips = '<Comma separated list of IPs>'
    end
    
     @ig_results = []  
    client = Instagram.client(:access_token => session[:access_token])
  tags = client.tag_search('#CanadianTuxedo')
  #html << "<h2>Tag Name = #{tags[0].name}. Media Count =  #{tags[0].media_count}. </h2><br/><br/>"
  for media_item in client.tag_recent_media(tags[0].name)        
      @ig_results.push(media_item) 
   # html << "<img src='#{media_item.images.thumbnail.url}'>"
  end   
    
    erb :home
end


















get '/tweets' do
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "X5tRK3AK2iWMSf542zMpXM4DC"
    config.consumer_secret     = "1tGmuinA6KJqVKuWQwK7QNraZZKlsPdnxxzD87MEuTgoswq45j"
    config.access_token        = "1875505560-kZNbBGn5OowWAA8yRfqiBh75O1FHbqz5TfHckhy"
    config.access_token_secret = "0JU47mOnOw4VFx4pNZHallL2oyYTDbTXCtWZnUaaq8pPk"
end
    
    @search_results = client.search("Affordable Care Act", result_type: "recent").take(30).collect do |tweet|
    #"#{tweet.user.screen_name}: #{tweet.text}"
        tweet
    end
    
    @title = "Denim Tweets"
    @description = "This page contains my tweeets that _____"
    @tweets = "active"
    erb :tweets
end


get '/news' do
    require 'google-search'
    query = "Affordable Care Act"
    @results = Array.new
    Google::Search::News.new do |search|
         search.query = query
        search.size = :large
     end.each { |item| @results.push item}
    erb :news
           
    end
      
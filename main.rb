require 'sinatra'
require 'sinatra/reloader' if development?
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

get "/" do
    @title = "Joel Patterson's Portfolio"
    @description = "This site showcases all of the awesome things that Joel Patterson has done."
    erb :home
end

get '/about' do
    @title = "About Me"
    @description = " This page provides a short bio for Joel Patterson"
    @about = "active"
    erb :about
end

get '/works' do
    @title = "My Clips"
    @description = " This page provides links to Joel Patterson's published clips."
    erb :work
end

get '/tweets' do
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "X5tRK3AK2iWMSf542zMpXM4DC"
    config.consumer_secret     = "1tGmuinA6KJqVKuWQwK7QNraZZKlsPdnxxzD87MEuTgoswq45j"
    config.access_token        = "1875505560-kZNbBGn5OowWAA8yRfqiBh75O1FHbqz5TfHckhy"
    config.access_token_secret = "0JU47mOnOw4VFx4pNZHallL2oyYTDbTXCtWZnUaaq8pPk"
end
    
    @search_results = client.search("#CanadianTuxedo", result_type: "recent").take(30).collect do |tweet|
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
      
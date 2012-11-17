class Reddit < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://buttons.reddit.com/button_info.json?url=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    children = JSON.parse(response)['data']['children']
    
    return { :count => 0 } if children.empty?
    entry = children.first['data']
    { 
      :count => entry['score'],
      :ups => entry['ups'],
      :downs => entry['downs'],
      :comments => entry['num_comments'],
      :subreddit => entry['subreddit'],
      :permalink => 'http://www.reddit.com' + entry['permalink'],
      :title => entry['title']
    }
  end
end
class Facebook < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://api.ak.facebook.com/restserver.php?v=1.0&method=links.getStats&format=json&urls=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    data = JSON.parse(response)
    
    { 
      :count => data[0]['total_count'],
      :shares => data[0]['share_count'],
      :likes => data[0]['like_count'],
      :comments => data[0]['comment_count']
    }
  end
end
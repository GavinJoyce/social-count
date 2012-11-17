class Twitter < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://urls.api.twitter.com/1/urls/count.json?url=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    { :count => JSON.parse(response)['count']}
  end
end
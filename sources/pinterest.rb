class Pinterest < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://api.pinterest.com/v1/urls/count.json?url=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    data = JSON.parse(response[13..-2]) #remove jsonp method wrapper 'receiveCount()'
    { :count => data['count'] || 0 }
  end
end
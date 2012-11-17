class Linkedin < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://www.linkedin.com/countserv/count/share?format=json&url=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    { :count => JSON.parse(response)['count'] }
  end
end
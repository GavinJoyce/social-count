class StumbleUpon < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://www.stumbleupon.com/services/1.01/badge.getinfo?url=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    data = JSON.parse(response)['result']
    return { :count => 0 } if data['views'].nil?
    {
      :count => Integer(data['views'])
    }
  end
end
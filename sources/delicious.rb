class Delicious < SocialSource
  def get_request(url)
    EM::HttpRequest.new('http://feeds.delicious.com/v2/json/urlinfo/data?url=' + URI.escape(url)).aget
  end
  
  def parse_response(response)
    data = JSON.parse(response).first
    return { :count => 0 } if data.nil?
    
    {
      :count => data['total_posts'],
      :tags => data['top_tags']
    }
  end
end
class GooglePlus < SocialSource
  def get_request(url)
    
    payload = [{
      "method" => "pos.plusones.get",
      "id" => "p",
      "params" => {
        "nolog" => true,
        "id" => url,
        "source" => "widget",
        "userId" => "@viewer",
        "groupId" => "@self"
      },
      "jsonrpc" => "2.0",
      "key" => "p",
      "apiVersion" => "v1"
    }]
    
    request_options = {
      :body => payload.to_json,
      :head => {'Content-Type' =>'application/json'}
    }
    
    request = EM::HttpRequest.new('https://clients6.google.com/rpc?key=AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ').apost request_options
    
  end
  
  def parse_response(response)
    data = JSON.parse(response)[0]    
    return { :count => 0 } if data == nil or data['error']
    {
      :count => Integer(data['result']['metadata']['globalCounts']['count'])
    }
  end
end


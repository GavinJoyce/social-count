class SocialSource
  include EM::Deferrable
  attr_accessor :data

  def execute(url)
    request = get_request(url)
    request.callback do
      @data = self.parse_response(request.response)
      succeed()
    end
    request.errback { fail }
    self
  end
  
  def parse_response(response)
    response
  end
end
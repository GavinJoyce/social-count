require 'goliath'
require 'em-synchrony/em-http'
require 'yajl/json_gem'
require 'require_all'
require_all 'sources'

class API < Goliath::API
  use Goliath::Rack::Params
  use Goliath::Rack::Heartbeat
  use Goliath::Rack::Render, 'json'
  use Goliath::Rack::Validation::RequestMethod, %w(GET)
  use Goliath::Rack::Validation::RequiredParam, {:key => 'url'}
    
  def response(env)
    url = env.params['url']
    
    multi = EventMachine::Synchrony::Multi.new
    
    [Twitter, Reddit, Linkedin, Delicious, Facebook, GooglePlus, Pinterest, StumbleUpon].each do |klass|
      multi.add klass.name.downcase.to_sym, klass.new.execute(url)
    end
    
    sources = multi.perform.responses[:callback]    
    response = {
      :url => url,
      :count => sources.values.inject(0) {|r, e| r + (e.data[:count] || 0)},
      :sources => Hash[sources.sort.map {|k,v| [k, v.data]}]
    }
    
    [200, {}, JSON.pretty_generate(response)]
  end
end
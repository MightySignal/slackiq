require 'net/http'

class SlackSidekiq
  
  class << self
    
    def configure(options={})
      @@webhook_url = options[:webhook_url]
    end
    
    def post
      text = 'sample data'
  
      json = {text: text}.to_json
      HTTParty.post(@@webhook_url, body: json)
    end
    
    
    
  end
  
end
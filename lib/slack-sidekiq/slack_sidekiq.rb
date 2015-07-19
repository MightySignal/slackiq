require 'net/http'
require 'json'
require 'httparty'

class SlackSidekiq
  
  class << self
    
    # def configure(options={})
    #   @@webhook_url = options[:webhook_url]
    # end
    
    def configure(webhook_url)
      @@webhook_url = webhook_url
    end
    
    def post
      text = 'hello'
      
      attachments = 
      [
        {
            "fallback" => "Required plain-text summary of the attachment.",

            "color" => "#00ff66",

            "title" => "Sidekiq Batch Completed",

            "text" => "Optional text that appears within the attachment",

            "fields" => [
                {
                    "title" => "Priority",
                    "value" => "High",
                    "short" => false
                }
            ],

            "image_url" => "http://my-website.com/path/to/image.jpg",
            "thumb_url" => "http://example.com/path/to/thumb.png"
        }
    ]
    
      body = {attachments: attachments}.to_json
      
      HTTParty.post(@@webhook_url, body: body)
  end
    
    
    
  end
  
end
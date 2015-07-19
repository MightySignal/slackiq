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

          "text" => "<Put batch description here>",

          "fields" => 
          [
            {
              "title" => "Created at",
              "value" => "2/24/2015 at 12:12 pm",
              "short" => true
            },
            {
              "title" => "Duration",
              "value" => "23:24:12",
              "short" => true
            },
            {
              "title" => "Total Jobs",
              "value" => "124129129",
              "short" => true
            },
            {
              "title" => "Failures",
              "value" => "1002",
              "short" => true
            },
            {
              "title" => "Failure %",
              "value" => "3.02%",
              "short" => true
            },
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
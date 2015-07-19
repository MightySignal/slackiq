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
      # text = {
      #     "attachments" => [
      #         {
      #             "fallback" => "Required plain-text summary of the attachment.",
      #
      #             "color" => "#36a64f",
      #
      #             "pretext" => "Optional text that appears above the attachment block",
      #
      #             "author_name" => "Bobby Tables",
      #             "author_link" => "http://flickr.com/bobby/",
      #             "author_icon" => "http://flickr.com/icons/bobby.jpg",
      #
      #             "title" => "Slack API Documentation",
      #             "title_link" => "https://api.slack.com/",
      #
      #             "text" => "Optional text that appears within the attachment",
      #
      #             "fields" => [
      #                 {
      #                     "title" => "Priority",
      #                     "value" => "High",
      #                     "short" => false
      #                 }
      #             ],
      #
      #             "image_url" => "http://my-website.com/path/to/image.jpg",
      #             "thumb_url" => "http://example.com/path/to/thumb.png"
      #         }
      #     ]
      # }.to_json
      
      text = 'hello'
      
      attachments = 
      [
        {
            "fallback" => "Required plain-text summary of the attachment.",

            "color" => "#36a64f",

            "pretext" => "Optional text that appears above the attachment block",

            "author_name" => "Bobby Tables",
            "author_link" => "http://flickr.com/bobby/",
            "author_icon" => "http://flickr.com/icons/bobby.jpg",

            "title" => "Slack API Documentation",
            "title_link" => "https://api.slack.com/",

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
    
      body = {text: text, attachments: attachments}.to_json
      
      HTTParty.post(@@webhook_url, body: body, attachments: attachments)
  end
    
    
    
  end
  
end
require 'net/http'
require 'json'
require 'httparty'

class Slackiq
  
  class << self
    
    # def configure(options={})
    #   @@webhook_url = options[:webhook_url]
    # end
    
    def configure(webhook_urls={})
      raise 'Argument must be a Hash' unless webhook_urls.class == Hash
      @@webhook_urls = webhook_urls
    end
    
    def notify(webhook_url_name, description, status, extra_fields={})
      url = @@webhook_urls[webhook_url_name]
      
      created_at = status.created_at
      finished_at = DateTime.now
      
      fields =  [
                  {
                    "title" => "Created at",
                    "value" => "2/24/2015 at 12:12 pm",
                    "short" => true
                  },
                  {
                    "title" => "Completed at",
                    "value" => "2/25/2015 at 12:12 pm",
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
                ]
      
      # add extra fields
      fields += extra_fields.map do |title, value|
        {
          "title" => title,
          "value" => value,
          "short" => false
        }
      end
                
      attachments = 
      [
        {
          "fallback" => "Sidekiq Batch Completed! (#{description})",

          'color' => '#00ff66',

          'title' => 'Sidekiq Batch Completed',

          'text' => description,

          'fields' => fields,
        }
    ]
    
      body = {attachments: attachments}.to_json
      
      HTTParty.post(@@webhook_url, body: body)
    end
    
 
    
    
    
  end
  
end
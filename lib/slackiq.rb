require 'slackiq/version'

require 'net/http'
require 'json'
require 'httparty'

require 'slackiq/time_helper'

require 'active_support/core_ext' #for Hash#except

module Slackiq
  
  class << self
    
    def configure(webhook_urls={})
      raise 'Argument must be a Hash' unless webhook_urls.class == Hash
      @@webhook_urls = webhook_urls
    end
    
    def notify(options={})  
      url = @@webhook_urls[options[:webhook_name]]
      title = options[:title]
      description = options[:description]
      status = options[:status]
      extra_fields = options.except(:webhook_name, :description, :status)
      
      if status
        created_at = status.created_at
      
        if created_at
          completed_at = Time.now
          duration = Slackiq::TimeHelper.elapsed_time_humanized(created_at, completed_at)
        end
      
        total_jobs = status.total
        failures = status.failures
      
        failure_percentage = (failures/total_jobs.to_f)*100 if total_jobs && failures
      end
      
      fields =  [
                  {
                    "title" => "Created",
                    "value" => Slackiq::TimeHelper.format(created_at),
                    "short" => true
                  },
                  {
                    "title" => "Completed",
                    "value" => Slackiq::TimeHelper.format(completed_at),
                    "short" => true
                  },
                  {
                    "title" => "Duration",
                    "value" => duration,
                    "short" => true
                  },
                  {
                    "title" => "Total Jobs",
                    "value" => total_jobs,
                    "short" => true
                  },
                  {
                    "title" => "Failures",
                    "value" => status.failures,
                    "short" => true
                  },
                  {
                    "title" => "Failure %",
                    "value" => "#{failure_percentage}%",
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

          'title' => title,

          'text' => description,

          'fields' => fields,
        }
    ]
    
      body = {attachments: attachments}.to_json
      
      HTTParty.post(url, body: body)
    end
    
  end
  
end
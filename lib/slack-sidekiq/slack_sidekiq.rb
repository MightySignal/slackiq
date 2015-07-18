class SlackSidekiq
  
  class << self
    
    def configure(options={})
      @@webhook_url = options[:webhook_url]
    end
    
    def hook
      @@webhook_url
    end
    
  end
  
end
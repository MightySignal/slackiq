# Slackiq (UNDER CONSTRUCTION. DO NOT INSTALL YET!)

Slackiq integrates [Slack](https://slack.com/) and [Sidekiq Pro](http://sidekiq.org/pro/) so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack.

<Insert Graphic>

## Installation

Add this line to your Gemfile:

`gem 'slackiq'`

## Configuration

First, set up any number of Slack Incoming Webhooks [from your Slack](https://slack.com/services/new/incoming-webhook).

Then, you only need to call the `configure` method when your application launches to configure all of the webhooks to which you want to post. If you're using Rails, create an initializer at `config/initializers/slackiq.rb`. Here's an example:

```
Slackiq.configure( web_scrapes: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/lknsaHHA2323KKDKND', 
                   data_processing: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/H24dLKAHD22423')
```

## Usage

You can call `notify` to send a nicely-formatted notification to your Slack.

The `notify` method has a single Hash parameter. Here are the keys and values in the Hash:
* `:webhook_name` The name of the webhook (Symbol) that you configured (eg. `:main` or `:data_processing`)
* `:title` The title of the notification (String)
* `:status` An instance of `Sidekiq::Batch::Status`
* Any other keys and values (both Strings) can be added too, and they'll be added to notification too.

Here's an example showing how you would use Slackiq to send a notification to your Slack when your Sidekiq batch completes:

```
class WebScraper
  
  class << self
  
    # Scrape the first 100 URLs in the database
    def scrape_100
      batch = Sidekiq::Batch.new
      batch.description = 'Scrape the first 100 URLs!' 
      batch.on(:complete, self)
      
      batch.jobs do
        
      urls = Url.limit(100) # Url is a Rails model in this case
      
      urls.each do |url|
        ScraperWorker.perform_async(url.id)
      end
    end
  
  end
  
  def on_complete(status, options)
    Slackiq.notify(webhook_name: :web_scrapes, status: status, title: 'Scrape Completed!', 'Total URLs in DB' => URL.count.to_s, 'Servers' => "#{Server.active_count} active, #{Server.inactive_count} inactive" )
  end
  
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MightySignal/slackiq. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


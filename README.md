# Slackiq

Slackiq integrates [Slack](https://slack.com/) and [Sidekiq](http://sidekiq.org) so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack.

![demo](http://i.imgur.com/4NLq2rP.gif)

## Installation

Add this line to your Gemfile:

`gem 'slackiq'`

Then run:

`bundle install`

## Configuration

First, set up any number of Slack Incoming Webhooks [from your Slack](https://slack.com/services/new/incoming-webhook).

Then, you only need to call the `configure` method when your application launches to configure all of the webhooks to which you want to post. If you're using Rails, create an initializer at `config/initializers/slackiq.rb`. Here's an example:

```
Slackiq.configure( web_scrapes: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/lknsaHHA2323KKDKND', 
                   data_processing: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/H24dLKAHD22423')
```

`:web_scrapes` and `data_processing` are examples of keys. Use whatever keys you want.

## Usage

You can call `notify` to send a nicely-formatted notification to your Slack. You can call `notify`

* Inside the Sidekiq Pro `on_success` or `on_complete` callback (not available on regular Sidekiq--only Pro)
* From inside a Sidekiq worker while it's running, in which case you should pass in the `bid` to the `perform` method of the worker

The `notify` method has a single Hash parameter. Here are the keys and values in the Hash:
* `:webhook_name` The name of the webhook (Symbol) that you configured (eg. `:web_scrapes` or `:data_processing`)
* `:title` The title of the notification (String)
* `:status` An instance of `Sidekiq::Batch::Status`
* Any other keys and values (both Strings) can be added too, and they'll be added to the Slack notification!

If you haven't used batches with Sidekiq Pro before, [read this first](https://github.com/mperham/sidekiq/wiki/Batches).

Here's an example showing how you would use Slackiq to send a notification to your Slack when your Sidekiq batch completes:

```ruby
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
    Slackiq.notify(webhook_name: :web_scrapes, status: status, title: 'Scrape Completed!', 
    'Total URLs in DB' => URL.count.to_s, 
    'Servers' => "#{Server.active_count} active, #{Server.inactive_count} inactive")
  end
  
end
```

Note that in this case, `'Total URLs in DB'` and `'Servers'` are custom fields that will also appear in Slack!

### Want to send a message to Slack that isn't Sidekiq-related?

No prob. Just: 

```
Slackiq.message('Server 5 is overloaded!', webhook_name: :data_processing)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MightySignal/slackiq. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Blog Post about Slackiq

https://medium.com/@MightySignal/slackiq-a-ruby-gem-that-connects-slack-and-sidekiq-a2308c1974b7


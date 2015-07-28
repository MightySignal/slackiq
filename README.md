# Slackiq (UNDER CONSTRUCTION. DO NOT INSTALL YET!)

Slackiq integrates [Slack](https://slack.com/) and [Sidekiq Pro](http://sidekiq.org/pro/) so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack.

<Insert Graphic>

## Installation

Add this line to your Gemfile:

`gem 'slackiq'`

## Configuration

First, set up any number of Slack Incoming Webhooks [from your Slack](https://slack.com/services/new/incoming-webhook).

Then, call the code below when your application launches to configure all of the webhooks to which you will post. If you're using Rails, create an initializer at `config/initializers/slackiq.rb`. You only need to call one method (`Slackiq.configure(hash_of_your_webhooks)`). Here's a sample:

```
Slackiq.configure( main: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/lknsaHHA2323KKDKND', 
                   another_key: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/H24dLKAHD22423')
```

## Usage


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MightySignal/slackiq. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


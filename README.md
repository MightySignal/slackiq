# Slackiq (UNDER CONSTRUCTION. DO NOT INSTALL YET!)

Slackiq integrates Slack and Sidekiq Pro so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack.

## Installation

If you're using Bundler, add this line to your Gemfile:

`gem 'slackiq'`

If not, install it manually:

`gem install slackiq`

## Configuration
```
Slackiq.configure( main_channel: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/lknsaHHA2323KKDKND', 
                   another_channel: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/H24dLKAHD22424', 
                   a_third_channel: 'https://hooks.slack.com/services/HA298HF2/ALSKF2451/asf124ASKJHFSAF23')
```

## Usage


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MightySignal/slackiq. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


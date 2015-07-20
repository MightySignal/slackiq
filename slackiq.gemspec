Gem::Specification.new do |s|
  s.name          = 'Slackiq'
  s.version       = '0.0.0'
  s.licenses      = ['MIT']
  s.summary       = "Slackiq integrates Slack and Sidekiq Pro so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack."
  s.description   = "Much longer explanation of the example!"
  s.authors       = ['MightySignal', 'Jason Lew']
  s.files         = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.homepage      = 'https://github.com/MightySignal/slackiq'
  s.add_dependency 'httparty', '0.13.5'
end
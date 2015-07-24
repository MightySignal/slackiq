Gem::Specification.new do |s|
  s.name          = 'slackiq'
  s.version       = '0.0.0'
  s.licenses      = ['MIT']
  s.description   = "Slackiq integrates Slack and Sidekiq Pro so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack."
  s.authors       = ['MightySignal', 'Jason Lew']
  s.files         = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.homepage      = 'https://github.com/MightySignal/slackiq'
  s.add_dependency 'httparty'
end
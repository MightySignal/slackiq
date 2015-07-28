# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slackiq/version'

Gem::Specification.new do |spec|
  spec.name          = "slackiq"
  spec.version       = Slackiq::VERSION
  spec.authors       = ['Jason Lew']
  spec.email         = ['jason@mightysignal.com']
  spec.summary       = 'MightySignal: Slack and Sidekiq Pro integration'
  spec.description   = "Slackiq (by MightySignal) integrates Slack and Sidekiq Pro so that you can have vital information about your Sidekiq jobs sent directly to your team's Slack."
  spec.homepage      = 'https://github.com/MightySignal/slackiq'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end

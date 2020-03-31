# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slackiq/version'

Gem::Specification.new do |s|
  s.name          = "HornsAndHooves-slackiq"
  s.version       = Slackiq::VERSION
  s.authors       = ["HornsAndHooves", "Peter Maneykowski"]
  s.email         = ['maneyko@integracredit.com']
  s.summary       = 'HornsAndHooves: Slack and Sidekiq Pro integration'
  s.description   = "Slackiq (by HornsAndHooves) integrates Slack and Sidekiq so that you can "\
                    "have vital information about your Sidekiq jobs sent directly to your team's Slack."
  s.homepage      = 'https://github.com/HornsAndHooves/slackiq'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'httparty'
  s.add_dependency "rails", "> 4.0", "< 6.0"

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
end

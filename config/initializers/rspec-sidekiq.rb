# This patch is here because it is impossible to simulate failures with the rspec-sidekiq gem.
# failures is a function that will always return 0:
# https://github.com/philostler/rspec-sidekiq/blob/2cd15b0fe2b172243e8002c4aefa39696c42d52f/lib/rspec/sidekiq/batch.rb#L42

require 'rspec/core'

module Sidekiq
  class Batch
    class SuccessStatus; end
    class FailureStatus; end
  end
end

module RSpec
  module Sidekiq
    class FailureStatus < NullStatus
      def failures
        1
      end
    end

    class SuccessStatus < NullStatus
      def failures
        0
      end
    end
  end
end

RSpec.configure do |config|
  config.before(:each) do |example|
    allow(Sidekiq::Batch::SuccessStatus).to receive(:new)  { RSpec::Sidekiq::SuccessStatus.new }
    allow(Sidekiq::Batch::FailureStatus).to receive(:new)  { RSpec::Sidekiq::FailureStatus.new }
  end
end

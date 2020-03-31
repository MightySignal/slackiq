# RSpec::Sidekiq::Batch::Status does not support batch failures.
# Here, FailureStatus and SuccessStatus circumvent this problem.

if defined?(RSpec)
  require 'rspec-sidekiq'

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
end

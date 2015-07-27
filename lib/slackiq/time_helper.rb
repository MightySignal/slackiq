require 'date'

module Slackiq
  module TimeHelper

    class << self
    
      def elapsed_time_humanized(t0, t1)
        humanize(elapsed_seconds(t0, t1))
      end
  
      def elapsed_seconds(t0, t1)
        dt0 = t0.to_datetime
        dt1 = t1.to_datetime
        ((dt1-dt0)*24*60*60).to_i
      end
  
      # http://stackoverflow.com/questions/4136248/how-to-generate-a-human-readable-time-range-using-ruby-on-rails
      def humanize(secs)
        [[60, :s], [60, :m], [24, :h], [1000, :d]].map{ |count, name|
          if secs > 0
            secs, n = secs.divmod(count)
            "#{n.to_i}#{name}"
          end
        }.compact.reverse.join(' ')
      end
      
      def format(time)
        time.strftime('%D @ %r').gsub('PM', 'pm').gsub('AM', 'am')
      end
  
    
    end
    
  end
end




require 'date'

module Slackiq
  module DateTime

    def elapsed_time_humanized(dt0, dt1)
      humanize(elasped_seconds(dt0, dt1))
    end
  
    def elasped_seconds(dt0, dt1)
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
  
  end
end




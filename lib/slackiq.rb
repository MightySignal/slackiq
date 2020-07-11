require "net/http"
require "uri"
require "json"
require "date"

class Slackiq

  VERSION = "1.2.1".freeze

  attr_reader :options

  # @param options [Hash]
  def self.notify(options)
    new(options).execute
  end

  # @param options [Hash]
  def self.configure(webhook_urls={})
    @@webhook_urls = webhook_urls
  end

  # @param options [Hash]
  def initialize(options)
    @options = options
  end

  # Send a notification to Slack with Sidekiq info about the batch
  def execute
    time_now = Time.now

    title    = options[:title]
    status   = options[:status]

    if (bid = options[:bid]) && status.nil?
      raise <<~EOT.chomp unless defined?(Sidekiq::Batch::Status)
               Sidekiq::Batch::Status is not defined. \
               Are you sure Sidekiq Pro is set up correctly?
               EOT
      status = Sidekiq::Batch::Status.new(bid)
    end

    return if status.nil?

    color = options[:color] || color_for(status)

    duration  = Slackiq::TimeHelper.elapsed_time_humanized(status.created_at, time_now)
    time_now_title = (status.complete? ? "Completed" : "Now")

    jobs_run = status.total - status.pending

    completion_percentage = percentage(jobs_run        / status.total.to_f)
    failure_percentage    = percentage(status.failures / status.total.to_f)

    fields = [
      {
        title: "Created",
        value: time_format(created_at),
        short: true
      },
      {
        title: time_now_title,
        value: time_format(time_now),
        short: true
      },
      {
        title: "Duration",
        value: duration,
        short: true
      },
      {
        title: "Total Jobs",
        value: status.total,
        short: true
      },
      {
        title: "Jobs Run",
        value: jobs_run,
        short: true
      },
      {
        title: "Completion %",
        value: completion_percentage,
        short: true
      },
      {
        title: "Failures",
        value: status.failures,
        short: true
      },
      {
        title: "Failure %",
        value: failure_percentage,
        short: true
      }
    ]

    attachments = [
      {
        fallback: title,
        title:    title,
        text:     status.description,
        fields:   fields,
        color:    color
      }
    ]

    body = { attachments: attachments }

    http_post(body)
  end

  # @param data [Hash]
  private def http_post(data)
    url  = @@webhook_urls[options[:webhook_name]]
    uri  = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.port == 443

    header  = {"Content-Type": "application/json"}
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = data.to_json
    http.request(request)
  end

  # @param number [Numeric]
  # @param precision [Integer]
  # @param multiply100 [Boolean]
  private def percentage(number, precision: 2, multiply100: true)
    number  = number * 100 if multiply100
    rounded = number.to_f.round(precision)
    format  = number == rounded.to_i ? "%.f" : "%.#{precision}f"
    (format % rounded) + "%"
  end

  # @param status [Sidekiq::Batch::Status]
  private def color_for(status)
    colors = {
      red:    "f00000",
      yellow: "ffc000",
      green:  "009800"
    }

    if status.total == 0
      colors[:yellow]
    elsif status.failures > 0
      colors[:red]
    elsif status.failures == 0
      colors[:green]
    else
      colors[:yellow]
    end
  end

  # @param t0 [DateTime]
  # @param t1 [DateTime]
  private def elapsed_time_humanized(t0, t1, precision: 2)
    time_humanize(elapsed_seconds(t0, t1))
  end

  # @param t0 [DateTime]
  # @param t1 [DateTime]
  private def elapsed_seconds(t0, t1, precision: 2)
    dt0 = t0.to_datetime
    dt1 = t1.to_datetime
    ((dt1 - dt0) * 24 * 60 * 60).to_f.round(precision)
  end

  # http://stackoverflow.com/questions/4136248/how-to-generate-a-human-readable-time-range-using-ruby-on-rails
  # @param secs [Integer]
  private def time_humanize(secs)
    [[60, :s], [60, :m], [24, :h], [1000, :d]].map do |count, name|
      if secs > 0
        secs, n = secs.divmod(count)
        if name == :s
          num = n.to_f == n.to_i ? n.to_i : n.to_f
          "%.2f#{name}" % [num]
        else
          "#{n.to_i}#{name}"
        end
      end
    end.compact.reverse.join(" ")
  end

  # @param time [DateTime]
  private def time_format(time)
    time.strftime("%D @ %H:%M:%S %P")
  end
end

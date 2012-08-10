module Devtimer
  class Timer
    attr_reader :log, :name, :number

    def initialize(number, name)
      @number = number
      @name = name
      @log = Log.new self

      @running = false
      @run_before_secs = 0.0 #running time excluding current run
      @running_last_since = nil #beginning of current run
    end

    def running?
      @running
    end

    def start
      return Alert.new "timer already running" if running?
      now = Time.now

      @running = true
      @running_last_since = now

      @log << "Timer started at #{now}"

      return self
    end

    def stop
      return Alert.new "timer not running" unless running?
      now = Time.now

      @running = false
      @run_before_secs += @running_last_since.how_long_ago(now)
      @running_last_since = nil

      @log << "Timer stopped at #{now}"

      return self
    end

    def add(seconds)
      @run_before_secs += seconds

      @log << "Added #{seconds.inspect} at #{Time.now}"

      return self
    end

    def delete
      timers.delete self
    end

    def running_time
      seconds = @run_before_secs
      seconds += @running_last_since.how_long_ago if running?
      return seconds.as_time_interval
    end

    def current?
      timers.current(no_alert: true) == self
    end

    def short_summary
      strings = [
        "(#{@number.to_s.rjust(3)}) ",
        "#{@name}:".ljust(20),
        "#{running_time},".ljust(20),
        running? ? 'running!' : 'stopped.'
      ]
      strings << ' (current)' if current?

      return strings.join ''
    end
    alias_method :inspect, :short_summary
  end
end
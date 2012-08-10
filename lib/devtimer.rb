#for delegate and stuff like 3.minutes
require 'active_support/core_ext'

require 'devtimer/alert'
require 'devtimer/log'
require 'devtimer/timer'
require 'devtimer/timers'
require 'devtimer/time_interval'

require 'debugger'

module Devtimer
  class << self
    def timers
      @timers ||= Timers.new
    end

    def current
      timers.current
    end
    alias_method :timer, :current

    def irb_loop
      finished = false
      until finished
        IRB.start

        if timers.empty?
          finished = true
        else
          puts "Restarting irb because there are still timers!"
          puts "Use 'timers.delete_all' to get rid of them."
        end
      end
    end

    def start
      at_exit do
        puts timers.inspect unless @exit_fine or timers.empty?
      end

      Object.send :include, Global

      begin
        irb_loop
      rescue
        raise
      else
        @exit_fine = true
      end
    end

    #this is a hack which will give a warning from irb
    # def quit
    #   debugger
    #   puts
    #   super
    # end
    # alias_method :exit, :quit
  end

  module Global
    delegate :timers, :timer, to: Devtimer
  end
end

#these should go somewhere else
class Time
  def to_s
    strftime '%F at %R'
  end

  def how_long_ago(from = Time.now)
    from - self
  end
end

class Float
  def as_time_interval
    Devtimer::TimeInterval.new self
  end
end

class Object
  def alert?
    false
  end
end

Devtimer.start
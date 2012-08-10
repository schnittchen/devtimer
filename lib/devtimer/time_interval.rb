module Devtimer
  class TimeInterval
    def initialize(secs)
      @secs = secs
    end

    def to_s
      seconds = @secs

      hours = seconds.div 3600
      seconds %= 3600

      minutes = seconds.div 60
      seconds %= 60

      return "#{hours}h #{minutes.to_s.rjust(2)}' #{seconds.round(1).to_s.rjust(4)}''"
    end
    alias_method :inspect, :to_s
  end
end

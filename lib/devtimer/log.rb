module Devtimer
  class Log < Array
    def initialize(timer)
      @timer = timer
    end

    def inspect
      return "#{@timer.inspect}\nLog is empty" if empty?
      return clone.prepend(@timer.inspect).join("\n")
    end
  end
end

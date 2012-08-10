module Devtimer
  class Timers < Array
    def self.new_number
      if @last_number
        return @last_number += 1
      else
        return @last_number = 1
      end
    end

    def new(name = nil)
      return Alert.new "Please give a name." unless name and name.is_a? String
      return Alert.new "Name already taken" if
        any? { |timer| timer.name == name }

      timer = Timer.new Timers.new_number, name
      self << timer

      switch_to timer unless @current

      return timer
    end

    def inspect
      return "No timers defined! Use timers.new 'name' to create one." if empty?
      map(&:short_summary).prepend("Timers:").join"\n"
    end

    def current(options = {})
      unless options[:no_alert]
        return Alert.new "No current timer!" unless @current
      end
      return @current
    end

    delegate :start, :stop, :add, :log, :running?, to: :current

    def switch_to(timer)
      timer = normalize_timer timer
      return timer if timer.alert?

      return timer if timer.current?

      @current.stop if @current

      @current = timer

      return timer
    end

    def delete(timer)
      timer = normalize_timer(timer)
      return timer if timer.alert?

      return Alert.new "Cowardly refusing to delete a running timer" if timer.running?

      @current = nil if @current == timer
      super timer
    end

    def delete_all
      return Alert.new "Cowardly refusing to delete a running timer" if
        @current && timer.running?
      @current = nil
      clear
    end

    private

    def normalize_timer(timer_or_number)
      return timer_or_number if timer_or_number.is_a? Timer
      result = find do |timer|
        timer.number == timer_or_number
      end
      return result if result
      return Alert.new "Could not identify timer #{timer_or_number.inspect}"
    end
  end
end

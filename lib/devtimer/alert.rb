module Devtimer
  class Alert < String
    def initialize(message)
      replace message
    end

    def alert?
      true
    end

    def inspect
      self
    end

    def method_missing(method, *args)
      return self
    end
  end
end

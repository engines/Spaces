module Framework
  class Error < StandardError

    def initialize(error)
      STDOUT.puts error.inspect
      pp caller_locations
    end

  end
end

module Recovery
  class Error < StandardError

    def initialize(error)
      STDOUT.puts error.inspect
    end

  end
end

module Streaming
  module Producing

    def produce(&block)
      yield(self)
    rescue => e
      if command.input[:background]
        exception(e) 
      else
        raise e
      end 
    end

    def output_lines_from(io)
      io.each_line { |l| output(l) }
    end

  end
end

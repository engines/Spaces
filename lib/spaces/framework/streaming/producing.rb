module Streaming
  module Producing

    def produce(&block)
      yield(self)
    rescue => e
      command.input[:background] ? exception(e) : raise(e)
    end

    def output_lines_from(io)
      io.each_line { |l| output(l) }
    end

  end
end

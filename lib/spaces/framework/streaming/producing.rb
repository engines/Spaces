module Streaming
  module Producing

    def produce(&block)
      yield(self)
    rescue => e
      logger.error(e)
      exception
    end

    def output_lines_from(io)
      io.each_line { |l| output(l) }
    end

  end
end

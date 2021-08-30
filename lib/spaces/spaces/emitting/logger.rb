module Emitting
  class Logger
    def initialize(io)
      @callback = ->(chunk) { yield chunk if block_given? }
      @io = io
    end

    def follow
      yield self
    end

    def unknown(chunk); write(:unknown, chunk) ;end
    def fatal(chunk); write(:fatal, chunk) ;end
    def error(chunk); write(:error, chunk) ;end
    def warn(chunk); write(:warn, chunk) ;end
    def info(chunk); write(:info, chunk) ;end
    def debug(chunk); write(:debug, chunk) ;end

    def write(level, chunk)
      logger.send(level, chunk.sub(/\n$/, ''))
      @callback.call(chunk)
      @io.write(chunk)
    end

    # def tap
    #   debugger
    # end

    def method_missing(m, *args, &block)
      debugger
    end
  end
end

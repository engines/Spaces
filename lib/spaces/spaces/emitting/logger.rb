module Emitting
  class Logger
    def initialize(io)
      @io = io
      @callback = ->(chunk) { yield chunk if block_given? }
    end

    def follow
      yield self
    end

    def write(level, chunk)
      logger.send(level, chunk.sub(/\n$/, ''))
      @io.write(chunk)
      @callback.call(chunk)
    end

    def method_missing(m, *args, &block)
      write(m, *args)
    end
  end
end

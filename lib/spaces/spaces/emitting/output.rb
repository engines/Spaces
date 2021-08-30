module Emitting
  class Output
    def initialize(filepath)
      @file = File.open(filepath, 'w')
      @callback = ->(chunk) { yield chunk if block_given? }
    end

    def follow(&block)
      ::Logger.new(self).tap &block
    end

    def write(chunk)
      logger.info(chunk.sub(/\n$/, ''))
      @file.write(chunk)
      @callback.call(chunk)
    end

    def close
      @file.close
    end
  end
end

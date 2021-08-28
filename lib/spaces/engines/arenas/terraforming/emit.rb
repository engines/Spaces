module Arenas
  module Terraforming
    class Emit
      def initialize
        @output = ->(chunk) { yield chunk if block_given? }
      end
      def open(&block)
        @logger ||= Logger.new(self).tap &block
      end
      def write(chunk)
        puts chunk
        @output.call(chunk)
      end
      def close
        @logger.close
      end
    end
  end
end

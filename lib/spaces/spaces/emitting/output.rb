module Spaces
  module Emitting
    class Output
      def self.emit_to(filepath, callback)
        self.new(filepath, callback).open do |emit|
          begin
            yield emit
          ensure
            emit.close
          end
        end
      end

      def initialize(filepath, callback)
        @filepath = filepath
        @callback = callback
      end

      def open(&block)
        FileUtils.mkpath(@filepath.dirname)
        @file = File.open(@filepath, 'w')
        self.tap &block
      end

      def write(chunk, opts)
        logger.send(opts[:level], chunk.sub(/\n$/, ''))
        @file.write(chunk)
        @callback.call(chunk)
      end

      def close
        @file.close
      end

      def method_missing(m, *args, &block)
        write(args[0], level: m)
      end

      def respond_to_missing?(*args)
        @file.respond_to?(*args)
      end
    end
  end
end

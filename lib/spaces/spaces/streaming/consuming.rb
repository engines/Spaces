module Spaces
  module Streaming
    module Consuming

      def consume(&block)
        File.open(path, 'r').tap { |f| follow(f, &block) }
      end

      protected

      def follow(file, &block)
        select([file])
        loop do
          sleep 0.01
          file.gets.tap do |line|
            next unless line
            return if is_eot?(line)
            yield line
          end
        end
      end

      def is_eot?(line)
        line[0] == EOT
      end

    end
  end
end

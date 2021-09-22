module Spaces
  module Streaming
    module Consuming

      def consume
        File.open(path, 'r').tap { |f| follow(f) }
      end

      protected

      def follow(file)
        select([file])
        loop do
          sleep 0.01
          file.gets.tap do |line|
            next unless line
            return if is_eot?(line)
          end
        end
      end

      def is_eot?(line)
        line[0] == eot
      end

    end
  end
end

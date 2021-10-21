module Spaces
  module Streaming
    module Producing

      def produce(&block)
        clear
        yield
      rescue => e
        exception(e)
      ensure
        append(eot)
      end

      def output_lines_from(io)
        io.each_line { |l| output(l) }
      end

      def output(line)
        append(encoded_output_for(line))
      end

      def error(line)
        append(encoded_error_for(line))
      end

      def exception(e)
        append(encoded_exception_for(e))
      end

      protected

      def clear
        path.dirname.mkpath
        File.open(path, 'w') {}
      end

      def append(line)
        File.open(path, 'a') { |f| f.write("#{line}\n") }
      end

      def encoded_output_for(line)
        {output: line}.to_json
      end

      def encoded_error_for(line)
        {error: line}.to_json
      end

      def encoded_exception_for(e)
        {exception: exception_message_for(e)}.to_json
      end

      def exception_message_for(e)
        [e.message, *e.backtrace].join("\n")
      end

    end
  end
end

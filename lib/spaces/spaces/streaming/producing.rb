module Spaces
  module Streaming
    module Producing

      def produce(&block)
        clear
        yield
      rescue => e
        collect_exception(e)
      ensure
        append(eot)
      end

      def collect(io)
        io.each_line { |l| append(message(l)) }
        append(message("\n"))
      end

      protected

      def clear
        path.dirname.mkpath
        File.open(path, 'w') {}
      end

      def message(line)
        {message: standard_for(:output, line)}
      end

      def standard_for(type, value)
        {}.tap { |h| h[type] = value }.to_json
      end

      def collect_exception(e)
        append(standard_for(:exception, exception_message_for(e)))
      end

      def append(line)
        File.open(path, 'a') { |f| f.write("#{line}\n") }
      end

      def exception_message_for(e)
        [e.message, *e.backtrace].join("\n")
      end

    end
  end
end

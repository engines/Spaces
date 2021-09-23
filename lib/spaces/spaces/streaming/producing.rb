module Spaces
  module Streaming
    module Producing

      def produce(&block)
        clear
        yield
      rescue => e
        append(exception_for(e))
      ensure
        append(eot)
      end

      def collect(io, &block)
        io.each_line { |l| append({message: yield(l)}.to_json) }
      end

      def append(line)
        File.open(path, 'a') { |f| f.write("#{line}\n") }
      end

      protected

      def clear
        path.dirname.mkpath
        File.open(path, 'w') {}
      end

      def exception_for(e)
        {exception: exception_message_for(e)}.to_json
      end

      def exception_message_for(e)
        [e.message, *e.backtrace].join("\n")
      end

    end
  end
end

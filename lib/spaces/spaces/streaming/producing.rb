module Spaces
  module Streaming
    module Producing

      def produce
        clear
        execute
      rescue => e
        exception(e)
      ensure
        eot
      end

      protected

      def execute
        # command.execute do |output|
        #   out(output)
        # end
      end

      def clear
        path.dirname.mkpath
        File.open(path, 'w') {}
      end

      def out(message)
        append({message: message}.to_json)
      end

      def append(line)
        File.open(path, 'a') { |f| f.write("#{line}\n") }
      end

      def eot; append(EOT) ;end

      def exception(e)
        append({exception: exception_message_for(e)}.to_json)
      end

      def exception_message_for(e)
        [e.message, *e.backtrace].join("\n")
      end

    end
  end
end

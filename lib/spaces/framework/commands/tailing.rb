module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Streaming::Streaming

      def stream_elements = [space.identifier, input_for(:identifier), stream_identifier, input_for(:timestamp)]

      protected

      def commit
        self.tap { stream.consume(callback) }
      rescue Errno::ENOENT => e
        # Allow tailing to commence before file has been created.
        wait_and_retry(e)
      rescue => e
        callback.call({exception: "Server error. Tailing failed."}.to_json)
        raise e
      end

      def wait_and_retry(e)
        @committed_at ||= Time.now
        raise e if (Time.now - @committed_at) > 10
        sleep 1
        commit
      end
      #
      # def to_h_deep = {}

      def default_callback
        ->(encoded) {
          message = JSON.parse(encoded, symbolize_names: true)
          print "#{message[:output]}" if message[:output]
          print "\033[0;33m#{message[:error]}\033[0m" if message[:error]
          print "\033[0;31m#{message[:exception]}\033[0m" if message[:exception]
        }
      end

    end
  end
end

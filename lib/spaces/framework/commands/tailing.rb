module Spaces
  module Commands
    class Tailing < ::Spaces::Commands::Command
      include ::Streaming::Streaming

      def stream_elements
        [ space.identifier,
          input_for(:identifier),
          stream_identifier,
          input_for(:timestamp)
        ]
      end

      protected

      def commit
        stream.consume(callback)
      rescue Errno::ENOENT => e
        # Allow tailing to commence before file has been created.
        wait_and_retry(e)
      rescue => e
        # Handle exceptions differently when tailing a file, because the normal
        # response object is not returned to client when streaming output.
        callback.call({exception: "#{e}"}.to_json)
        logger.debug(e)
      end

      def wait_and_retry(e)
        @committed_at ||= Time.now
        raise e if (Time.now - @committed_at) > 10
        sleep 0.1
        commit
      end

    end
  end
end

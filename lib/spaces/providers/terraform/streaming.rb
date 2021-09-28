module Providers
  module Terraform
    module Streaming
    include ::Spaces::Streaming

      def config(stream)
        {
          stdout: stdout(stream),
          stderr: stdout(stream),
          logger: logger
        }
      end

      def stdout(stream)
        ->(output) do
          stream.append(output_json_for(output))
          logger.info(output)
        end
      end

      def stderr(stream)
        ->(error) do
          stream.append(error_json_for(error))
          logger.warn(error)
        end
      end

      def output_json_for(output)
        {output: output}.to_json
      end

      def error_json_for(error)
        {error: error}.to_json
      end

    end
  end
end

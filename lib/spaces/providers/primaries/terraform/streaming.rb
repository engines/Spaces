module Providers
  module Terraform
    module Streaming

    def config(out)
      {
        stdout: out,
        stderr: out,
        logger: logger
      }
    end

    def out(command, model)
      ->(output) do
        stream_for(model, command).output(output)
        logger.info(output.strip)
      end
    end

    end
  end
end

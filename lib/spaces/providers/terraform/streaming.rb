module Providers
  module Terraform
    module Streaming

    def config(out) =
      {
        stdout: out,
        stderr: out,
        logger: logger
      }

    def out(command, model) =
      ->(output) { stream_for(:orchestrations, model, command).output(output) }

    end
  end
end

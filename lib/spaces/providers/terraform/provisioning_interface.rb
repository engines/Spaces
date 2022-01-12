require_relative 'streaming'

module Providers
  module Terraform
    class ProvisioningInterface < ::Providers::Interface
      include Streaming

      def execute(command, model)
        with_streaming(model, command) do
          identifier.tap { provisioning_for(command, model) }
        end
      end

      protected

      def provisioning_for(command, model)
        stream_for(model, command).tap do |stream|
          stream.output("\n") unless command == :init
          Dir.chdir(path_for(model)) do
            bridge.send(command, options[command] || {}, config(out(command, model)))
            stream.output("\n")
          rescue RubyTerraform::Errors::ExecutionError => e
            stream.output("\n")
            stream.error("#{e}\n")
          end
        end
      end

      def bridge; RubyTerraform ;end

      def options
        {
          plan: {
            input: false
          },
          apply: {
            input: false,
            auto_approve: true
          }
        }
      end

    end
  end
end

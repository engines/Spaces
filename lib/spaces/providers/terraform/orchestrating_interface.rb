require_relative 'streaming'

module Providers
  module Terraform
    class OrchestrationInterface < ::Providers::Interface
      include Streaming

      def execute(command, model)
        with_streaming(:orchestrations, model, command) do
          identifier.tap { orchestration_for(command, model) }
        end
      end

      protected

      def orchestration_for(command, model)
        stream_for(:orchestrations, model, command).tap do |s|
          s.output("\n") unless command == :init
          Dir.chdir(path_for(model)) do
            bridge.send(command, options[command] || {}, config(out(command, model)))
            s.output("\n")
          rescue RubyTerraform::Errors::ExecutionError => e
            s.output("\n")
            s.error("#{e}\n")
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

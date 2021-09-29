require_relative 'streaming'
require_relative 'providing'

module Providers
  module Terraform
    class Terraform < ::ProviderAspects::Provider
      include Streaming
      include Providing

      alias_method :arena, :emission

      delegate(other_identifiers: :arena)

      def execute(command, model)
        with_streaming(model, command) do
          identifier.tap { provisioning_for(command, model) }
        end
      end

      def aspect_name_elements; super.uniq ;end

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

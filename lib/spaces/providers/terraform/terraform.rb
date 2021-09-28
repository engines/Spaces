require_relative 'streaming'
require_relative 'runtime_providing'

module Providers
  module Terraform
    class Terraform < ::ProviderAspects::Provider
      include Streaming
      include RuntimeProviding

      alias_method :arena, :emission

      delegate(
        [:provider_aspects, :runtime_provider] => :arena
      )

      def execute(command, model)
        with_streaming(model, command) do
          identifier.tap { provisioning_for(command, model) }
        end
      end

      protected

      def provisioning_for(command, model)
        Dir.chdir(path_for(model)) do
          bridge.send(command, options[command] || {}, config(stream_for(model, command)))
        rescue RubyTerraform::Errors::ExecutionError => e
          raise e
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

require_relative 'streaming'

module Providers
  module Terraform
    class ArenaInterface < ::Providers::Interface

      alias_method :arena, :emission

      def execute(command)
        identifier.tap { orchestration_for(execution_map[:"#{command}"]) }
      end

      protected

      def orchestration_for(command)
        stream&.output("\n") unless command == :init
        Dir.chdir(path_for(model)) do
          bridge.send(command, options[command] || {}, config(out(command, arena)))
          stream&.output("\n")
        rescue RubyTerraform::Errors::ExecutionError => e
          stream&.output("\n")
          stream&.error("#{e}\n")
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

module Providers
  module Terraform
    class ArenaInterface < ::Providers::Interface

      alias_method :arena, :emission

      delegate(
        arenas: :universe,
        path_for: :arenas,
        [:copy_auxiliaries, :remove_auxiliaries] => :arena
      )

      def execute(command)
        identifier.tap { orchestration_for(command) }
      end

      protected

      def orchestration_for(command)
        stream&.output("\n") unless command == :init
        Dir.chdir(path_for(arena)) do
          # copy_auxiliaries
          bridge.send(command, options[command] || {})
          stream&.output("\n")
          # remove_auxiliaries
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

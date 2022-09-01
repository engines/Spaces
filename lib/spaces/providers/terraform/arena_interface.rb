module Providers
  module Terraform
    class ArenaInterface < ::Providers::Interface

      alias_method :arena, :emission

      delegate(
        arenas: :universe,
        path_for: :arenas,
        all_orchestrations: :arena
      )

      def execute(command)
        identifier.tap do
          orchestration_for(command)
          arena.save_cache
        end
      end

      protected

      def orchestration_for(command)
        stream&.output("\n") unless command == :init
        Dir.chdir(path_for(arena)) do
          copy_artifacts
          bridge.send(command, options[command] || {})
          stream&.output("\n")
        rescue RubyTerraform::Errors::ExecutionError => e
          stream&.output("\n")
          stream&.error("#{e}\n")
        ensure
          remove_artifacts
        end
      end

      def copy_artifacts
        all_orchestrations.map do |o|
          arenas.copy_artifacts_for(o)
        end
      end

      def remove_artifacts
        all_orchestrations.map do |o|
          arenas.remove_artifacts_for(o)
        end
      end

      def bridge = RubyTerraform

      def options =
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

module Providers
  module DockerCompose
    class ArenaInterface < ::Providers::Interface

        alias_method :arena, :emission

        delegate(
          arenas: :universe,
          [:copy_auxiliaries, :remove_auxiliaries] => :arena
        )

        def execute(command)
          identifier.tap { orchestration_for(execution_map[:"#{command}"]) }
        end

        protected
        
        def orchestration_for(command)
          copy_auxiliaries
          bridge.send(command) do |io, bytes|
            stream&.error(bytes) if io == :stderr
            stream&.output(bytes) if io == :stdout
          end
          remove_auxiliaries # FIX: this doesn't happen until the send thread is finished!
        rescue ::Docker::Compose::Error => e
          # No need to send message to stream. Error already reported in :stderr above.
        end

        def plan
          bridge.config(arena.orchestrated.map(&:identifier))
        end

        def execution_map =
          {
            plan: :build,
            apply: :up
          }

        def bridge
          @bridge ||=
            ::Docker::Compose::Session.new(
              dir: arenas.path_for(arena),
              file: 'docker-compose.yaml'
            )
        end

    end
  end
end

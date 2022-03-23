require_relative 'streaming'

module Providers
  module DockerCompose
    class ProvisioningInterface < ::Providers::Interface
      include Streaming

        relation_accessor :arena

        delegate(
          arenas: :universe,
          [:copy_auxiliaries, :remove_auxiliaries] => :arena
        )

        def execute(command)
          identifier.tap { provisioning_for(execution_map[:"#{command}"]) }
        end

        def provisioning_for(command)
          copy_auxiliaries
          with_streaming(arena, command) do |stream|
            begin
              bridge.send(command) do |io, bytes|
                stream.error(bytes) if io == :stderr
                stream.output(bytes) if io == :stdout
              end
            rescue ::Docker::Compose::Error => e
              # No need to send message to stream. Error already reported in :stderr above.
              pp e.inspect
            end
          end
          remove_auxiliaries # TODO: this doesn't happen until the send thread is finished!
        end

        def plan
          bridge.config(arena.provisioned.map(&:identifier))
        end

        def execution_map
          {
            plan: :build,
            apply: :up
          }
        end

        def bridge
          @bridge ||=
            ::Docker::Compose::Session.new(
              dir: arenas.path_for(arena),
              file: 'docker-compose.yaml'
            )
        end

        def initialize(arena)
          self.arena = arena
        end

    end
  end
end

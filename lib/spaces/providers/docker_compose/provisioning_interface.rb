require 'docker/compose'
require_relative 'streaming'

module Providers
  module DockerCompose
    class ProvisioningInterface < ::Providers::Interface
      include Streaming

        delegate(packs: :universe)

        alias_method :arena, :emission

        def execute(command)
          identifier.tap { provisioning_for(execution_map[:"#{command}"]) }
        end

        def provisioning_for(command)
          copy_auxiliaries
          bridge.send(command)
        rescue ::Docker::Compose::Error => e
          pp e.inspect
        ensure
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
              dir: path_for(arena),
              file: 'docker-compose.yaml'
            )
        end

        protected

        def copy_auxiliaries
          arena.all_packs.each { |p| packs.copy_auxiliaries_for(p) }
        end

        def remove_auxiliaries
          arena.all_packs.each { |p| packs.remove_auxiliaries_for(p) }
        end

    end
  end
end

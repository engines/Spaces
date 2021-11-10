require 'docker/compose'
require_relative 'streaming'

module Providers
  module DockerCompose
    class Interface < ::Providers::Interface
      include Streaming

        delegate(packs: :universe)

        alias_method :arena, :emission

        def execute(command)
          identifier.tap { send(command) }
        end

        def apply
          copy_auxiliaries
          bridge.up(arena.provisioned.map(&:identifier))
        rescue ::Docker::Compose::Error => e
          pp e.inspect
        ensure
          remove_auxiliaries
        end

        def plan
          bridge.config(arena.provisioned.map(&:identifier))
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

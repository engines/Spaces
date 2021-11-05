require 'docker/compose'
require_relative 'streaming'

module Providers
  module DockerCompose
    class Interface < ::Providers::Interface
      include Streaming

        alias_method :arena, :emission

        def execute(command)
          identifier.tap { send(command) }
        end

        def apply
          bridge.up(arena.provisioned.map(&:identifier))
        rescue ::Docker::Compose::Error => e
          pp e.inspect
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

    end
  end
end

require 'docker/compose'
require_relative 'streaming'

module Providers
  module DockerCompose
    class Interface < ::Providers::Interface
      include Streaming

        def execute(command)
          identifier.tap { send(command) }
        end

        def apply
          bridge.up(emission.provisioned.map(&:identifier))
        end

        def plan
          bridge.config(emission.provisioned.map(&:identifier))
        end

        def bridge
          @bridge ||=
            ::Docker::Compose::Session.new(
              dir: path_for(emission),
              file: 'docker-compose.yaml'
            )
        end

    end
  end
end

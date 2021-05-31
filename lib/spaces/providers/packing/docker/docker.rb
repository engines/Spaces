require 'docker-api'

module Providers
  class Docker < ::Providers::Provider

    def create(descriptor)
      bridge.create(
        name: descriptor.identifier,
        Image: descriptor.identifier,
        Volumes: { descriptor.identifier => {} }
      )
    end

  end
end

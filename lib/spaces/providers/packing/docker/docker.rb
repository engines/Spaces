require 'docker-api'

module Providers
  class Docker < ::ProviderAspects::Provider

    alias_method :pack, :emission

    def save
      path_for(pack).join("DockerFile").write(pack.artifact.values.join("\n"))
    end

    def create(descriptor)
      bridge.create(
        name: descriptor.identifier,
        Image: descriptor.identifier,
        Volumes: { descriptor.identifier => {} }
      )
    end

  end
end

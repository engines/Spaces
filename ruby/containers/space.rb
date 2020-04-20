require_relative '../docker/containers/space'

module Containers
  class Space < ::Spaces::Space

    delegate(create: :bridge)

    def all(options = {})
      bridge.all(options.reverse_merge(all: true))
    end

    def by(descriptor)
      bridge.get(descriptor.identifier)
    end

    def bridge
      @bridge ||= Docker::Containers::Space.new
    end

  end
end

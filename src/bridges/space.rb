require_relative '../spaces/models/space'

module Bridges
  class Space < ::Spaces::Space

    delegate(create: :bridge)

    def all(options = {})
      bridge.all(options.reverse_merge(all: true))
    end

    def by(descriptor)
      bridge.get(descriptor.identifier)
    end

    def bridge; {} ;end

  end
end

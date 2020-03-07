require_relative 'relationship'

module Bindings
  class Anchor < Relationship

    def resolved_for(h)
      overrides_for(installation.binding_anchor&.variables).merge(h)
    end

    def installation
      @installation ||= universe.blueprints.by(descriptor).installation
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

  end
end

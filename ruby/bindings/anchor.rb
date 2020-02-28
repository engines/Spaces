require_relative 'relationship'

module Bindings
  class Anchor < Relationship

    def resolved_for(h)
      overrides_for(tensor.binding_anchor&.variables).merge(h)
    end

    def tensor
      @tensor ||= universe.blueprints.by(descriptor).tensor
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

  end
end

require_relative 'relationship'

module Bindings
  class Service < Relationship

    def resolved_for(h)
      overrides_for(tensor.bindings&.variables).merge(h)
    end

    def tensor
      @tensor ||= universe.blueprints.by(descriptor).tensor
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

  end
end

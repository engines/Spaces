require_relative 'relationship'

module Blueprint
  class Dependency < Relationship

    def resolution_for(h)
      overrides_for(tensor.dependents&.variables).merge(h)
    end

    def tensor
      @tensor ||= universe.blueprints.by(descriptor).tensor
    end

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

  end
end

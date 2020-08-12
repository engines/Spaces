require_relative '../releases/descriptive_subdivision'

module Inclusions
  class Inclusion < ::Releases::DescriptiveSubdivision

    def memento
      [
        struct,
        resolution.memento_for(:inclusions)
      ]
    end

    def descriptor; @descriptor ||= descriptor_class.new(root.descriptor) ;end

    def root
      @root ||= [struct].flatten.compact.first
    end

  end
end

require_relative '../spaces/model'

module Projects
  class Blueprint < ::Spaces::Model

    delegate(identifier: :descriptor)

    def anchor_descriptors
      struct.bindings&.map { |d| descriptor_class.new(d.descriptor) } || []
    end
  end
end

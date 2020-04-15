require_relative 'collaboration'

module Projects
  class Blueprint < Collaboration

    delegate(identifier: :descriptor)

    def anchor_descriptors
      struct.bindings&.map { |d| descriptor_class.new(d.descriptor) } || []
    end
  end
end

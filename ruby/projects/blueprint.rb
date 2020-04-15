require_relative '../spaces/model'
require_relative 'specification'

module Projects
  class Blueprint < ::Spaces::Model
    extend Specification

    delegate(identifier: :descriptor)

    def anchor_descriptors
      struct.bindings&.map { |d| descriptor_class.new(d.descriptor) } || []
    end
  end
end

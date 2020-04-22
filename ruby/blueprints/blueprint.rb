require_relative 'active_schema'
require_relative 'collaboration'

module Blueprints
  class Blueprint < ActiveSchema
  class Blueprint < Collaboration

    delegate(identifier: :descriptor)

    def anchor_descriptors
      struct.bindings&.map { |d| descriptor_class.new(d.descriptor) } || []
    end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.struct if descriptor
    end

  end
end

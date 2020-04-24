require_relative '../spaces/model'
require_relative 'schema'
require_relative 'collaboration'

module Blueprints
  class Blueprint < Collaboration

    class << self
      def schema_class
        Schema
      end
    end

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

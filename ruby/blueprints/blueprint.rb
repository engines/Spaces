require_relative '../releases/release'

module Blueprints
  class Blueprint < Releases::Release

    delegate(identifier: :descriptor)

    def anchor_descriptors
      @anchor_descriptors ||= struct.bindings&.map { |d| descriptor_class.new(d.descriptor) }
    end

    def memento; duplicate(struct) ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.memento if descriptor
    end

  end
end

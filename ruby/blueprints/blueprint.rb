require_relative 'collaboration'

module Blueprints
  class Blueprint < Collaboration

    delegate(identifier: :descriptor)

    def memento; duplicate(struct) ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.memento if descriptor
    end

  end
end

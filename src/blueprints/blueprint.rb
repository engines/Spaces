require_relative '../releases/release'

module Blueprints
  class Blueprint < Releases::Release

    def memento; duplicate(struct) ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.memento if descriptor
    end

  end
end

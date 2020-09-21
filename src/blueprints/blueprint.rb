require_relative '../releases/release'

module Blueprints
  class Blueprint < Releases::Release

    def emit; duplicate(struct) ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.emit if descriptor
    end

  end
end

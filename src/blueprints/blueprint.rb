require_relative '../emitting/emissions/emission'

module Blueprints
  class Blueprint < Emitting::Emission

    def emit; duplicate(struct) ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.emit if descriptor
    end

  end
end

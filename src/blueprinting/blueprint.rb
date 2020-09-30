require_relative '../emitting/emissions/emission'

module Blueprinting
  class Blueprint < Emissions::Emission

    def emit; duplicate(struct) ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.emit if descriptor
    end

  end
end

module Blueprinting
  class Blueprint < Emissions::Emission

    def descriptor
      @descriptor ||= descriptor_class.new(struct.descriptor)
    end

    def emit; duplicate(struct) ;end

    def initialize(struct: nil, identifier: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.identifier = identifier if identifier
    end

  end
end

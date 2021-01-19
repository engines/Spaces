module Publishing
  class Blueprint < Emissions::Emission

    def emit; duplicate(struct) ;end

    def initialize(struct: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier = identifier if identifier
    end

  end
end

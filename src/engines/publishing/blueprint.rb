module Publishing
  class Blueprint < Emissions::Emission

    def initialize(struct: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier = identifier if identifier
    end

  end
end

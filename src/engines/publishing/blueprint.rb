module Publishing
  class Blueprint < Emissions::Emission

    delegate(publications: :universe)

    def emit; duplicate(struct) ;end

    def descriptor; publications.by(identifier, Spaces::Descriptor) ;end

    def initialize(struct: nil, identifier: nil)
      super(struct: struct)
      self.struct.identifier = identifier if identifier
    end

  end
end

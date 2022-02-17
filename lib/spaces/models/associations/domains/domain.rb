module Domains
  class Domain < ::Spaces::Model

    def name; identifier ;end

    def identifier; struct[:identifier] ;end

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

  end
end

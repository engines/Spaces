module Classifying
  class Classifier < ::Spaces::Model

    def identifier = struct[:identifier]

    def initialize(struct: nil, identifiable: nil)
      super(struct: struct)
      self.struct.identifier = identifiable.identifier if identifiable
    end

  end
end

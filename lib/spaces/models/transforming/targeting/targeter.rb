module Targeting
  class Targeter < ::Spaces::Model

    relation_accessor :space
    attr_accessor :identifier

    def emission
      @target ||= space.exist_then_by(identifier)
    end

    def initialize(identifier, space)
      self.identifier = identifier
      self.space = space
    end

  end
end

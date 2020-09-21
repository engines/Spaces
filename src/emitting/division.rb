require_relative 'transformable'

module Emitting
  class Division < Transformable

    attr_accessor :label

    class << self
      def prototype(emission:, label:)
        new(emission: emission, label: label)
      end
    end

    relation_accessor :emission

    delegate(context_identifier: :emission)

    def initialize(struct: nil, emission: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || (emission.struct[label] if emission) || default
    end

    def to_s; struct ;end

  end
end

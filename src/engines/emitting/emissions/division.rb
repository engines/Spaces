require_relative 'transformable'

module Emissions
  class Division < Transformable

    attr_accessor :label

    class << self
      def prototype(emission:, label:)
        new(emission: emission, label: label)
      end

      def default_struct; OpenStruct.new ;end
    end

    relation_accessor :emission

    delegate(
      default_struct: :klass,
      context_identifier: :emission
    )

    def scale &block
      Array.new(emission.count) do |i|
        block.call(i)
      end
    end

    def initialize(emission:, struct: nil, label: nil)
      self.emission = emission
      self.label = label
      self.struct = struct || emission.struct[label] || default_struct
    end

    def to_s; struct ;end

  end
end

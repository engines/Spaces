module Interpolating
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    delegate(
      [:transformable, :interpolation_marker] => :text,
      emission: :transformable
    )

    def resolved
      amc = acceptable_method_chain_in_value

      collaborate_with(amc.first).send(*amc.last.split(/[()]+/))
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: value)
      "#{interpolation_marker}#{value}#{interpolation_marker}"
    end

    def acceptable_method_chain_in_value
      ([:unqualified] + value.split('.')).last(2)
    end

    def collaborate_with(name)
      unless name == :unqualified
        emission.respond_to?(:bindings) && emission.bindings.named(name) ||
        emission.respond_to?(name) && emission.send(name)
      else
        transformable
      end
    end

    def initialize(value:, text:)
      self.value = value
      self.text = text
    end

    def to_s; resolved ;end

  end
end

module Interpolating
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    delegate(
      [:transformable, :interpolation_marker] => :text,
      emission: :transformable
    )

    def complete?; !more_to_resolve? && unresolvable? ;end
    def more_to_resolve?; resolved.to_s.include?(interpolation_marker) ;end
    def unresolvable?; resolved == value ;end

    def resolved; @resolved ||= _resolved ;end

    def acceptable_method_chain_in_value
      @amc ||= ([:unqualified] + value.split('.')).last(2)
    end

    alias_method :amc, :acceptable_method_chain_in_value

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

    protected

    def _resolved
      collaborate_with(amc.first).send(*amc.last.split(/[()]+/))
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: value)
      value
    end

  end
end

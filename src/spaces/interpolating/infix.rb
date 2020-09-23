module Interpolating
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    delegate([:division, :emission] => :text)

    def resolved
      vs = ([:unqualified] + value.split('.')).last(2)
      collaborate_with(vs.first).send(*vs.last.split(/[()]+/))
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: value)
      "--->#{value}<---"
    end

    def collaborate_with(name)
      unless name == :unqualified
        emission.respond_to?(:bindings) && emission.bindings.named(name) ||
        division.respond_to?(:bindings) && division.bindings.named(name) ||
        emission.respond_to?(name) && emission.send(name) ||
        division.respond_to?(name) && division.send(name)
      else
        division
      end
    end

    def initialize(value:, text:)
      self.value = value
      self.text = text
    end

    def to_s; resolved ;end

  end
end

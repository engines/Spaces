require_relative '../spaces/model'

module Texts
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    delegate([:collaboration, :context] => :text)

    def resolved
      vs = ([:unqualified] + value.split('.')).last(2)
      collaborate_with(vs.first).send(*vs.last.split(/[()]+/))
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: value)
      "--->#{value}<---"
    end

    def collaborate_with(name)
      unless name == :unqualified
        context.respond_to?(:bindings) && context.bindings.named(name) ||
        collaboration.respond_to?(:bindings) && collaboration.bindings.named(name) ||
        context.respond_to?(name) && context.send(name) ||
        collaboration.respond_to?(name) && collaboration.send(name)
      else
        context
      end
    end

    def initialize(value:, text:)
      self.value = value
      self.text = text
    end

    def to_s; resolved ;end

  end
end

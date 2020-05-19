require_relative '../spaces/model'

module Texts
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    delegate(stage: :text)

    def resolution
      vs = ([:unqualified] + value.split('.')).last(2)
      collaborate_with(vs.first).send(*vs.last.split(/[()]+/))
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError => e
      warn(error: e, text: text, value: value)
      "--->#{value}<---"
    end

    def collaborate_with(name)
      unless name == :unqualified
        stage.bindings.named(name) || stage.send(name) || (raise NoMethodError)
      else
        text.context
      end
    end

    def initialize(value:, text:)
      self.value = value
      self.text = text
    end

    def to_s; resolution ;end

  end
end

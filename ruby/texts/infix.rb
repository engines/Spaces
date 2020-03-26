require_relative '../spaces/model'

module Texts
  class Infix < ::Spaces::Model

    relation_accessor :text
    attr_accessor :value

    def resolved
      vs = ([:unqualified] + value.split('.')).last(2)
      collaborate_with(vs.first).send(*vs.last.split(/[()]+/))
    rescue TypeError, ArgumentError, NoMethodError, SystemStackError
      "--->#{value}<---"
    end

    def collaborate_with(name)
      unless name == :unqualified
        installation.bindings.named(name) || installation.send(name) || (raise NoMethodError)
      else
        text.context
      end
    end

    def installation
      text.installation
    end

    def initialize(value:, text:)
      self.value = value
      self.text = text
    end

    def to_s
      resolved
    end

  end
end

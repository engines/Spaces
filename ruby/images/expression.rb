require_relative '../spaces/model'

module Images
  class Expression < ::Spaces::Model

    attr_accessor :value

    def resolved
      "--->#{value}<---"
    end

    def initialize(value)
      self.value = value
    end

    def to_s
      resolved
    end

  end
end

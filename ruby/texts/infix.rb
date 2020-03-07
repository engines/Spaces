require_relative '../spaces/model'
require_relative '../domains/bucket'
require_relative '../environments/bucket'

module Texts
  class Infix < ::Spaces::Model
    include Domains::Bucket
    include Environments::Bucket

    relation_accessor :context
    attr_accessor :value

    def resolved
      begin
        vs = value.split('.').last(2)
        collaborate_with(vs.first).send(*vs.last.split(/[()]+/))
      rescue ArgumentError, NoMethodError
        "--->#{value}<---"
      end
    end

    def collaborate_with(name)
      installation.bindings.named(name) || installation.send(name) || (raise NoMethodError)
    end

    def initialize(value:, context:)
      self.value = value
      self.context = context
    end

    def installation
      context.installation
    end

    def to_s
      resolved
    end

  end
end

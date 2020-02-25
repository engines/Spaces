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
        collaborate_with(vs.first).send(vs.last)
      rescue NoMethodError
        "--->#{value}<---"
      end
    end

    def collaborate_with(name)
      tensor.dependencies.named(name) ||
      tensor.domain ||
      (raise NoMethodError)
    end

    def initialize(value:, context:)
      self.value = value
      self.context = context
    end

    def tensor
      context.tensor
    end

    def to_s
      resolved
    end

  end
end

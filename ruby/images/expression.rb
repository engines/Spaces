require_relative '../spaces/model'
require_relative '../domains/bucket'
require_relative '../environments/bucket'

module Images
  class Expression < ::Spaces::Model
    include Domains::Bucket
    include Environments::Bucket

    relation_accessor :context
    attr_accessor :value

    def resolved
      begin
        value.split('.').last(2).reduce(self) { |m, i| m.send(i) }
      rescue NoMethodError
        "--->#{value}<---"
      end
    end

    def send(*args)
      begin
        super(*args)
      rescue NoMethodError
        collaborate_with(args.first)
      end
    end

    def collaborate_with(name)
      tensor.dependencies.named(name) || (raise NoMethodError)
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

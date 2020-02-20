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
      "--->#{value}<---"
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

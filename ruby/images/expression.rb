require_relative '../spaces/model'
require_relative '../domains/bucket'
require_relative '../environments/bucket'

module Images
  class Expression < ::Spaces::Model
    include Domains::Bucket
    include Envs::Bucket

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

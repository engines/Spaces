require_relative '../spaces/model'

module Software
  class MemoryUsage < ::Spaces::Model

    attr_accessor :required,
      :recommended

  end
end

require_relative '../framework/model'

module Software
  class MemoryUsage < ::Framework::Model

    attr_accessor :required,
      :recommended

  end
end

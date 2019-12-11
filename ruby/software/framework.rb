require_relative '../framework/model'

module Software
  class Framework < ::Framework::Model

    attr_accessor :label,
      :port_override

  end
end

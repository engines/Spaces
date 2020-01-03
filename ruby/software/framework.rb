require_relative '../spaces/model'

module Software
  class Framework < ::Spaces::Model

    attr_accessor :label,
      :port_override

  end
end

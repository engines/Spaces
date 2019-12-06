require_relative '../engines/model'

module Software
  class Framework < Engines::Model

    attr_accessor :label,
      :port_override

  end
end

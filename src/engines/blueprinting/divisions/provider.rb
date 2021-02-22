module Divisions
  class Provider < ::Divisions::Division

    def implementation
      struct.implementation || context_identifier
    end

  end
end

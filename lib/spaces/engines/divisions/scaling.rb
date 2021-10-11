module Divisions
  class Scaling < ::Divisions::Division

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

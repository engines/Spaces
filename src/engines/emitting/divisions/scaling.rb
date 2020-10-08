module Divisions
  class Scaling < ::Emissions::Division

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

require_relative '../emissions/division'

module Divisions
  class Scaling < ::Emitting::Division

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

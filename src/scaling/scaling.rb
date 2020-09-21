require_relative '../emitting/emissions/division'

module Scaling
  class Scaling < ::Emitting::Division

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

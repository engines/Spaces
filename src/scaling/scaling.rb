require_relative '../emitting/division'

module Scaling
  class Scaling < ::Emitting::Division

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

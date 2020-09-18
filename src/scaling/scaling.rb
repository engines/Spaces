require_relative '../releases/division'

module Scaling
  class Scaling < ::Releases::Division

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

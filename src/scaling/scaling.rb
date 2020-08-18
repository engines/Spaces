require_relative '../releases/component'

module Scaling
  class Scaling < ::Releases::Component

    def count; struct.provisions.to_h.values.max.to_i ;end

  end
end

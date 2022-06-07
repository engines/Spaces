#TODO: deprecate!
module Divisions
  class Scaling < ::Divisions::Division

    def count; struct.orchestration.to_h.values.max.to_i ;end

  end
end

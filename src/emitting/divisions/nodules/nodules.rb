require_relative '../../emissions/divisible'

module Nodules
  class Nodules < ::Emissions::Divisible

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, division: self)
    end

  end
end

require_relative '../emitting/emissions/divisible'

module Nodules
  class Nodules < ::Emitting::Divisible

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, division: self)
    end

  end
end

require_relative '../releases/divisible'

module Nodules
  class Nodules < ::Releases::Divisible

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, division: self)
    end

  end
end

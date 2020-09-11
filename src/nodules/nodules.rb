require_relative '../releases/division'

module Nodules
  class Nodules < ::Releases::Division

    def subdivision_for(struct)
      universe.nodules.by(struct: struct, division: self)
    end

  end
end

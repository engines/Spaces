module Divisions
  class Nodules < ::Emissions::Divisible

    def subdivision_for(struct)
      subdivision_class.prototype(struct: struct, division: self)
    end

  end
end

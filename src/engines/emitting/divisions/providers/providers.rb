module Divisions
  class Providers < ::Emissions::Divisible

    def subdivision_for(struct)
      subdivision_class.prototype(struct: struct, division: self)
    end

  end
end

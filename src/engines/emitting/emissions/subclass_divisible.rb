require_relative 'divisible'

module Emissions
  class SubclassDivisible < Divisible

    def subdivision_for(struct)
      subdivision_class.prototype(struct: struct, division: self)
    end

  end
end

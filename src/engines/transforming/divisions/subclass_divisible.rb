require_relative 'divisible'

module Divisions
  class SubclassDivisible < Divisible

    alias_method :generic_subdivision_for, :subdivision_for

    def subdivision_for(struct)
      subdivision_class.prototype(struct: struct, division: self)
    end

  end
end

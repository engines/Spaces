module Divisions
  class Images < ::Emissions::Divisible

    def script_file_names
      all.map(&:script_file_names).flatten.uniq
    end

    def subdivision_for(struct)
      subdivision_class.prototype(struct: struct, division: self)
    end

  end
end

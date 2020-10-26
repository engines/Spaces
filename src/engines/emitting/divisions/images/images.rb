module Divisions
  class Images < ::Emissions::SubclassDivisible

    def script_file_names
      all.map(&:script_file_names).flatten.uniq
    end

  end
end

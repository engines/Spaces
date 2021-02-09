module Divisions
  class Target < ::Emissions::Division

    def resolved
      duplicate(itself)
    end

  end
end

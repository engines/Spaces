module Divisions
  class Target < ::Divisions::Division

    def resolved
      duplicate(itself)
    end

  end
end

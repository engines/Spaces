module Divisions
  class Images < ::Emissions::SubclassDivisible

    def embed(other)
      tap do
        self.struct = [struct, other.struct].flatten.uniq(&:image)
      end
    end

  end
end

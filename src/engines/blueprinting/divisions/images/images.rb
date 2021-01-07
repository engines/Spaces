module Divisions
  class Images < ::Emissions::SubclassDivisible

    def struct_with(other) = super.uniq(&:image)

  end
end

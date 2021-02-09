module Divisions
  class Images < ::Emissions::SubclassDivisible

    def struct_with(other); super.uniq(&:image) ;end

    def inflated_struct; all.map(&:inflated_struct) ;end

  end
end

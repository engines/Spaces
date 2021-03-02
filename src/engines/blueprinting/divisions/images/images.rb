module Divisions
  class Images < ::Divisions::SubclassDivisible

    def struct_with(other); super.uniq(&:image) ;end

  end
end

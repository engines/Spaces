module Divisions
  class Images < ::Divisions::Divisible

    def struct_with(other); super.uniq(&:image) ;end

  end
end

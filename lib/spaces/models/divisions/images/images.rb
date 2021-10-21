module Divisions
  class Images < ::Divisions::Divisible

    def struct_merged_with(other); super.uniq(&:type) ;end

  end
end

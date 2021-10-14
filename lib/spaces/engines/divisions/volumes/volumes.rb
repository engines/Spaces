module Divisions
  class Volumes < ::Divisions::Divisible

    def struct_merged_with(other); super.uniq(&:source) ;end

  end
end

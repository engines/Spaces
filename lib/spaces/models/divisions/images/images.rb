module Divisions
  class Images < ::Divisions::Divisible

    def transformed_to(transformation)
      in_blueprint? ? super : super.select { |s| s.type == runtime_qualifier }
    end

    def struct_merged_with(other); super.uniq(&:type) ;end

  end
end

module Divisions
  class Images < ::Divisions::Divisible

    delegate packing_stanza: :provider_division_aspect

    def transformed_to(transformation)
      in_blueprint? ? super : super.select { |s| s.type == runtime_qualifier }
    end

    def struct_merged_with(other); super.uniq(&:type) ;end

  end
end

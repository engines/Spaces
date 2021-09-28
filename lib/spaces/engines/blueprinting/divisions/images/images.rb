module Divisions
  class Images < ::Divisions::Divisible
    include PackDefining

    delegate packing_artifact: :provider_aspect

    def transformed_to(transformation)
      in_blueprint? ? super : super.select { |s| s.type == runtime_identifier }
    end

    def struct_merged_with(other); super.uniq(&:type) ;end

  end
end

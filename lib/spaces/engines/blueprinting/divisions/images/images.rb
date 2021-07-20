module Divisions
  class Images < ::Divisions::Divisible
    include ProviderDependent

    delegate packing_artifact: :provider_aspect

    def provider_aspect_name_elements
      ['providers', packing_identifier, runtime_identifier, qualifier]
    end

    def transformed_to(transformation)
      in_blueprint? ? super : super.select { |s| s.type == runtime_identifier }
    end

    def struct_merged_with(other); super.uniq(&:type) ;end

  end
end

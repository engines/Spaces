module Divisions
  class Images < ::Divisions::Divisible
    include ProviderDependent

    delegate packing_artifact: :provider_aspect

    def provider_aspect_name_elements
      ['providers', packing_identifier, runtime_identifier, qualifier]
    end

    def transformed_to(transformation)
      if runtime_identifier
        super.select { |s| s.type == runtime_identifier }
      else
        super
      end
    end

  end
end

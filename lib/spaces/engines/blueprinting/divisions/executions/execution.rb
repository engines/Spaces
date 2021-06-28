module Divisions
  class Execution < ::Divisions::Subdivision
    include ProviderDependent

    def identifier; type ;end

    def inflated; self ;end
    def deflated; self ;end

    def provider_aspect_name_elements
      ['providers', packing_identifier, runtime_identifier, qualifier]
    end

  end
end

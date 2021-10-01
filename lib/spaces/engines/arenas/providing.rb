module Arenas
  module Providing

    def runtime_identifier
      runtime_binding&.runtime_identifier
    end

    def packing_identifier
      packing_binding&.packing_identifier
    end

    def other_identifiers
      provider_division_map.keys - [runtime_identifier, packing_identifier]
    end

    #---------------------------------------------------------------------------

    def runtime_aspect; execution_aspect_for(:runtime) ;end

    def packing_aspect; execution_aspect_for(:packing) ;end

    def execution_aspect_for(purpose); provider_division_aspect_map["#{purpose}"] ;end

    def provider_division_aspects; provider_division_aspect_map.values ;end

    def provider_division_aspect_map
      @provider_division_aspect_map ||= provider_division_map.transform_values(&:provider_division_aspect)
    end

    #---------------------------------------------------------------------------

    def other_provider_divisions
      other_identifiers.map { |i| provider_division_map[i] }
    end

    def provider_divisions; provider_division_map.values ;end

    def provider_division_map
      @provider_division_map ||= provider_resolution_map.transform_values(&:provider)
    end

    #---------------------------------------------------------------------------

    def provider_resolution_map
      @provider_resolution_map ||= resolution_map.select { |_, v| v.has?(:provider) }
    end

  end
end

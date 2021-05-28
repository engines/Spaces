module Arenas
  module Providing

    def providers; provider_map.values ;end

    def provider_aspects; providers.map(&:provider_aspect).compact ;end

    def runtime_provider
      @runtime_provider ||= providers.detect { |p| p.emission.defines_runtime_provider? }
    end

    def packing_provider
      @packing_provider ||= providers.detect { |p| p.emission.defines_packing_provider? }
    end

    def other_providers
      providers - [runtime_provider, packing_provider]
    end

    def runtime_identifier
      runtime_binding&.runtime_identifier
    end

    def packing_identifier
      packing_binding&.packing_identifier
    end

    def provider_resolutions; provider_resolution_map.values ;end

    def provider_map
      @provider_map ||= provider_resolution_map.transform_values(&:provider)
    end

    def provider_resolution_map
      @provider_resolution_map ||= resolution_map.select { |_, v| v.has?(:provider) }
    end

  end
end

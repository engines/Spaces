module Arenas
  module Providing

    def providers; provider_map.values ;end

    def runtime_provider
      @runtime_provider ||= providers.detect { |p| p.emission.defines_runtime_provider? }
    end

    def packing_provider
      @packing_provider ||= providers.detect { |p| p.emission.defines_packing_provider? }
    end

    def other_providers
      providers - [runtime_provider, packing_provider]
    end

    def provisioning_type
      [runtime_type, 'container'].compact.join('_')
    end

    def runtime_type
      runtime_binding&.runtime_type
    end

    def packing_type
      packing_binding&.packing_type
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

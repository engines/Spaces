module Arenas
  module Providing

    def runtime_provider; provider_for(:runtime) ;end
    def packing_provider; provider_for(:packing) ;end
    def provisioning_provider; provider_for(:provisioning) ;end

    def provider_for(purpose); provider_map[purpose] ;end

    def primary_providers
      providers.select do |p|
        zero.primary_provider_roles.include?(p.role)
      end
    end

    def subordinate_providers
       providers - primary_providers
    end

    def providers
      provider_map.values
    end

    def provider_map
      @provider_map ||= zero.keys.inject({}) do |m, k|
        m.tap do
          m[k] = zero.class_map[k].first.new(k)
        end
      end
    end

    def runtime_qualifier; runtime_provider.qualifier ;end
    def packing_qualifier; packing_provider.qualifier ;end

  end
end

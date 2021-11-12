module Arenas
  module Prerequisites
    include ::Providers::Providers

    def provider_role_map
      @provider_role_map ||= struct.input.to_h_deep
    end

    def prerequisite_map
      @prerequisite_map ||= provider_qualifier_map.transform_values do |v|
        resolution_map[v] || resolution_map[v.camelize.downcase] # TODO FIX: should be an installation_map after installations are declared properly in blueprints
      end.compact
    end

    def prerequisite_keys; prerequisite_map.keys ;end

    #???????????????????????????????????????????????????????????????????????????
    def runtime_provider; provider_for(:runtime) ;end
    def packing_provider; provider_for(:packing) ;end
    def provisioning_provider; provider_for(:provisioning) ;end

    def runtime_qualifier; runtime_provider.qualifier ;end
    def packing_qualifier; packing_provider.qualifier ;end
    def provisioning_qualifier; provisioning_provider.qualifier ;end
    #???????????????????????????????????????????????????????????????????????????

    def method_missing(m, *args, &block)
      provider_map["#{m}"] || super
    end

    def respond_to_missing?(m, *)
      provider_map.keys.include?("#{m}") || super
    end

    def method_missing(m, *args, &block)
      return prerequisite_map[m.to_sym] if prerequisite_keys.include?(m)
      super
    end

    def respond_to_missing?(m, *)
      prerequisite_keys.include?(m) || super
    end

  end
end

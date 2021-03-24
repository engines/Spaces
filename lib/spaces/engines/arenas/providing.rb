module Arenas
  module Providing

    def container_type
      "#{runtime_type}_container"
    end

    def runtime_type
      runtime_binding&.runtime_type
    end

    def provider_divisions; provider_division_map.values ;end

    def providers; provider_map.values ;end

    def provider_division_map
      @provider_division_map ||= provider_map.transform_values(&:provider)
    end

    def provider_map
      @provider_map ||= resolution_map.select { |_, v| v.has?(:provider) }
    end

    def method_missing(m, *args, &block)
      provider_division_map["#{m}"] || super
    end

    def respond_to_missing?(m, *)
      provider_division_map.keys.include?("#{m}") || super
    end

  end
end

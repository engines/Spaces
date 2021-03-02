module Arenas
  module Providing

    def provider_divisions; providers.map(&:provider) ;end

    def providers; provider_map.values ;end

    def provider_map
      @provider_map ||= resolution_map.select { |_, v| v.has?(:provider) }
    end

  end
end

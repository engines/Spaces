module Arenas
  module Providing

    def provider_divisions; providers.map(&:provider) ;end

    def providers; provider_map.values ;end

    def provider_map
      @provider_map ||= bindings.all.reduce({}) do |m, b|
        m.tap do
          b.resolution_in(self).tap do |r|
            m[b.identifier] = r if r.has?(:provider)
          end
        end
      end
    end

  end
end

module Arenas
  module Resolving

    def resolutions; resolution_map.values ;end

    def resolution_map
      @resolution_map ||= bindings.all.inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolution_in(self)
        end
      end
    end

  end
end

module Arenas
  module Resolving

    def resolutions; resolution_map.values ;end

    def resolution_map
      @resolution_map ||= connect_targets.inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolution_in(self)
        end
      end
    end

    def connect_targets
      super.map(&:blueprint).map(&:connect_targets).flatten
    end

  end
end

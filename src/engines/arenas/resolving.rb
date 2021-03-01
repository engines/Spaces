module Arenas
  module Resolving

    def resolutions; resolution_map.values ;end

    def resolution_map
      @resolution_map ||= maybe(:bindings).inject({}) do |m, b|
        m.tap do
          m[b.identifier] = b.resolution_in(self)
        end
      end
    end

    def maybe(method)
      has?(method) ? send(method).all : []
    end

  end
end

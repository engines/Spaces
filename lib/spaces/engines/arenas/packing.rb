module Arenas
  module Packing

    def packables; bound_resolutions.select(&:packable?) ;end

  end
end

module Arenas
  module Packing

    def packables; resolutions.select(&:packable?) ;end

  end
end

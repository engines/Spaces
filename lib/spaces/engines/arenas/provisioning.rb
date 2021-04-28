module Arenas
  module Provisioning

    def provisionables; bound_resolutions.select(&:provisionable?) ;end

  end
end

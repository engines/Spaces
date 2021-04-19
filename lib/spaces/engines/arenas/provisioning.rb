module Arenas
  module Provisioning

    def provisionables; resolutions.select(&:provisionable?) ;end

  end
end

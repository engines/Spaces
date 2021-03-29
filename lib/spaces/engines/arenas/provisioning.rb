module Arenas
  module Provisioning

    def provisioned; resolutions.map(&:provisioned) ;end

  end
end

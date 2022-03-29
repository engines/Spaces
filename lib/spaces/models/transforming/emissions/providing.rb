module Emissions
  module Providing

    def interface_for(emission)
      emission.provider_for(provider_role).interface_for(emission)
    end

  end
end

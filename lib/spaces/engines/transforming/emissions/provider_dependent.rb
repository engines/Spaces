module Emissions
  module ProviderDependent

    def provider_aspect_for(emission, space)
      ::ProviderAspects::Provider.prototype(emission, space)
    end

  end
end

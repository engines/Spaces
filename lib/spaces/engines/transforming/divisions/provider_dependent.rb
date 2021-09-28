module Divisions
  module ProviderDependent

    def provider_aspect
      @provider_aspect ||= ::ProviderAspects::Aspect.prototype(self)
    end

    def aspect_name_elements
      ['providers']
    end

  end
end

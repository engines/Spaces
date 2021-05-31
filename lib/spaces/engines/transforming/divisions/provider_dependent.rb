module Divisions
  module ProviderDependent

    def provider_aspect
      @provider_aspect ||= ::Providers::ProviderAspect.prototype(self)
    end

    def packing_artifact_for(key); provider_aspect.packing_artifact_for(key) ;end
    def resolution_stanzas_for(_); provider_aspect.resolution_stanzas_for(_) ;end

  end
end

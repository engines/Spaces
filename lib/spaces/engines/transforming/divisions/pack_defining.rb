require_relative 'provider_dependent'

module Divisions
  module PackDefining
    include ProviderDependent

    def aspect_name_elements
      [super, packing_identifier, qualifier].flatten
    end

    def packing_artifact_for(key)
      unless self == provider_aspect
        provider_aspect.packing_artifact_for(key)
      else
        super
      end
    end

  end
end

require_relative 'provider_dependent'

module Divisions
  module PackDefining
    include ProviderDependent

    def aspect_name_elements
      [super, packing_identifier, qualifier].flatten
    end

    def packing_stanza_for(key)
      unless self == provider_aspect
        provider_aspect.packing_stanza_for(key)
      else
        super
      end
    end

  end
end

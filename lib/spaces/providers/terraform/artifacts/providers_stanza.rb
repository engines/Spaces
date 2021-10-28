module Artifacts
  module Terraform
    class ProvidersStanza < ::Artifacts::Stanza

    def stanza_qualifiers
      provider_qualifiers
    end

    def stanza_class_for(qualifier)
      class_for(nesting_elements, qualifier, :provider_stanza)
    end


    end
  end
end

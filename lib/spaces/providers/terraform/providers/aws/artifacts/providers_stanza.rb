module Artifacts
  module Terraform
    module Aws
      class ProvidersStanza < ::Artifacts::Terraform::ProvidersStanza

        def stanza_class_for(qualifier)
          class_for(nesting_elements, :provider_stanza)
        end

      end
    end
  end
end

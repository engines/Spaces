module Artifacts
  module Terraform
    module Aws
      class ProvidersStanza < ::Artifacts::Stanza

        def snippets
          %(
            provider "aws" {
              region = "#{compute_provider&.region}"
            }
          )
        end

      end
    end
  end
end

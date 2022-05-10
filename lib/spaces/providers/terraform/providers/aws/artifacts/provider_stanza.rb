module Artifacts
  module Terraform
    module Aws
      class ProviderStanza < ::Artifacts::Stanza

        def snippets
          %(
            provider "aws" {
            }
          )
        end

      end
    end
  end
end

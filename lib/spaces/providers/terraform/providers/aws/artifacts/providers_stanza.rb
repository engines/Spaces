module Artifacts
  module Terraform
    module Aws
      class ProvidersStanza < ::Artifacts::Stanza

        def snippets
          %(
            provider "aws" {
              region = "ap-southeast-2"
            }
          )
        end

      end
    end
  end
end

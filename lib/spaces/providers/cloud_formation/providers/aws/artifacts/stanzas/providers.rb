module Artifacts
  module CloudFormation
    module Aws
      class ProvidersStanza < ::Artifacts::Stanza
        include Named

        def snippets =
          %(
            provider "aws" {
              region = "#{compute_provider&.region}"
            }
          )

      end
    end
  end
end

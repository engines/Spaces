module Artifacts
  module CloudFormation
    module Aws
      class ProvidersStanza < ::Artifacts::Stanza
        include Named

        def snippets =
          {
            "#{resource_identifier}": {
              Type: "??PROVIDER??",
              FIXME:
              %(
                provider "aws" {
                  region = "#{compute_provider&.region}"
                }
              )
            }
          }

      end
    end
  end
end

require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats
        class Providers < Hash

          def content =
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
end

require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class Providers < Hcl

          def content =
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

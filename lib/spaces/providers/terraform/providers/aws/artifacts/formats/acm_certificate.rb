require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats
        class AcmCertificate < Hcl

          def name_snippet = nil

          def more_snippets =
            %(
              domain_name       = "#{configuration.domain_name}"
              validation_method = "#{configuration.validation_method}"
              lifecycle {
                create_before_destroy = #{configuration.create_before_destroy}
              }
            )

        end
      end
    end
  end
end

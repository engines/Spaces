module Artifacts
  module Terraform
    module Aws
      module AcmCertificate
        class More < Snippet

          def content =
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

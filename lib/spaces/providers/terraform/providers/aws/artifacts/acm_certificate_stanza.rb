require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class AcmCertificateStanza < ResourceStanza
     def configuration_snippet
          %(
            domain_name       = #{configuration.domain_name}
            validation_method = #{configuration.validation_method}
            lifecycle {
                 create_before_destroy = #{configuration.create_before_destroy}
            }
          )
        end
      end
    end
  end
end

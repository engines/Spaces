require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class AcmCertificateStanza < ResourceStanza

        def more_snippets =
          %(
            domain_name       = "#{configuration.domain_name}"
            validation_method = "#{configuration.validation_method}"
            lifecycle {
                 create_before_destroy = #{configuration.create_before_destroy}
            }
          )

        def more_snippets_keys =
          [:domain_name, :validation_method, :create_before_destroy]

      end
    end
  end
end

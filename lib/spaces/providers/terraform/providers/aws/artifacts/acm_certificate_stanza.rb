require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class AcmCertificateStanza < ResourceStanza

        def more_snippets
          %(
	         domain_name = "#{configuration.domain_name}"       
          )
        end

      end
    end
  end
end

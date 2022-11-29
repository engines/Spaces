require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class AcmCertificateStanza < ResourceStanza

        def more_snippets = AcmCertificate::More.new(self).content

        def more_snippets_keys =
          [:domain_name, :validation_method, :create_before_destroy]

      end
    end
  end
end

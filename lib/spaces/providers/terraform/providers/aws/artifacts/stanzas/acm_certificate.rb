module Artifacts
  module Terraform
    module Aws
      class AcmCertificateStanza < ::Artifacts::Aws::AcmCertificateStanza

        def name_snippet = nil
        def more_snippets = AcmCertificate::More.new(self).content

      end
    end
  end
end

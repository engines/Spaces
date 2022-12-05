require_relative 'resource'

module Artifacts
  module Aws
    class AcmCertificateStanza < ResourceStanza

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::AcmCertificate.new(self)
      end

    end
  end
end

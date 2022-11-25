require_relative 'resource'

module Artifacts
  module Aws
    class AcmCertificateStanza < ResourceStanza

      def more_snippets_keys =
        [:domain_name, :validation_method, :create_before_destroy]

    end
  end
end

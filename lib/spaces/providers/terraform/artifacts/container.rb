module Artifacts
  module Terraform
    class Container < Artifact

      def stanza_qualifiers; [:container, :volume, :dns] ;end

      def dns_qualifier
        provider.dns_qualifier.camelize.downcase
      end

      def container_type
        [runtime_qualifier, 'container'].compact.join('_')
      end

    end
  end
end
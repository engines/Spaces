require_relative 'artifact'

module Artifacts
  module Terraform
    class Resource < Artifact

      def stanza_qualifiers; [:resource, :volume, :dns] ;end

      def dns_qualifier
        arena.qualifier_for(:dns).camelize.downcase
      end

      def resource_type
        [runtime_qualifier, 'container'].compact.join('_')
      end

    end
  end
end

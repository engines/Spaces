require_relative 'artifact'

module Artifacts
  module Terraform
    class Capsule < Artifact

      def stanza_qualifiers; [:capsule, :volume, :dns] ;end

      def dns_qualifier
        arena.qualifier_for(:dns).camelize.downcase
      end

      def capsule_type
        [runtime_qualifier, 'container'].compact.join('_')
      end

    end
  end
end

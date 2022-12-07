require_relative 'artifact'

module Artifacts
  module Terraform
    class Capsule < Artifact

      def stanza_qualifiers =
        [compute_service_identifier || :capsule]

      def dns_qualifier = arena.qualifier_for(:dns).camelize.downcase

      def capsule_type = [runtime_qualifier, 'container'].compact.join('_')

    end
  end
end

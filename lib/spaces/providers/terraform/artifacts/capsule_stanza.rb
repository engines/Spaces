module Artifacts
  module Terraform
    class CapsuleStanza < ::Artifacts::Stanza

      def snippets =
        %(
          resource "#{runtime_qualifier}_container" "#{application_identifier}" {
            name = "#{application_identifier}"
            image = "#{spaces_image_registry}#{image_identifier}"
            domainname = "#{arena.identifier.as_subdomain}.#{universe.host}"
            hostname = "#{application_identifier.as_subdomain}"

            #{volume_snippets if volumes}
          }
        )

      def volume_snippets = volumes.all.map(&:snippets).join

      def spaces_image_registry
        # "#{image_host}:" if image_host
      end

      def dependency_string
        connections_down.map do |c|
          "#{runtime_qualifier}.#{c.application_identifier}"
        end.join(', ')
      end

    end
  end
end

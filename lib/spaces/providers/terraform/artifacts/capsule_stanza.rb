module Artifacts
  module Terraform
    class CapsuleStanza < ::Artifacts::Stanza

      def snippets
        %(
          resource "#{runtime_qualifier}_container" "#{blueprint_identifier}" {
            name = "#{blueprint_identifier}"
            image = "#{spaces_image_registry}#{image_identifier}"
            domainname = "#{arena.identifier.as_subdomain}.#{universe.host}"
            hostname = "#{blueprint_identifier.as_subdomain}"

            #{volume_snippets if volumes}
          }
        )
      end

      def volume_snippets
        volumes.all.map(&:snippets).join
      end

      def spaces_image_registry
        # "#{image_host}:" if image_host
      end

      def dependency_string
        connections_down.map { |c| "#{runtime_qualifier}.#{c.blueprint_identifier}" }.join(', ')
      end

    end
  end
end

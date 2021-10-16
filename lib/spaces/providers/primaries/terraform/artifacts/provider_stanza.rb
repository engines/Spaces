module Artifacts
  module Terraform
    class ProviderStanza < ::Artifacts::Stanza

      def snippets
        %(
          provider "#{type}" {
            # Note need to expand this to support remote hosts
            host = "unix:///var/run/docker.sock"
          }
        )
      end

      def required_snippet
        %(
          docker = {
            version = "#{configuration.version}"
            source = "#{configuration.source}"
          }
        )
      end

    end
  end
end

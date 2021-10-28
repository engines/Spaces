module Artifacts
  module Terraform
    class ProviderStanza < ::Artifacts::Stanza

      def snippets
        %(
          provider "#{runtime_qualifier}" {
            # Note need to expand this to support remote hosts
            host = "unix:///var/run/docker.sock"
          }
        )
      end

    end
  end
end

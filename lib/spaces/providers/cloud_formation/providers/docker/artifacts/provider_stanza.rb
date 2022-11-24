module Artifacts
  module CloudFormation
    module Docker
      class ProviderStanza < ::Artifacts::Stanza

        def snippets =
          %(
            provider "#{qualification_for(:runtime)}" {
              # Note need to expand this to support remote hosts
              host = "unix:///var/run/docker.sock"
            }
          )

      end
    end
  end
end

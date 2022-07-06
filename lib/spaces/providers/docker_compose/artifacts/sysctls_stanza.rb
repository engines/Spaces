module Artifacts
  module DockerCompose
    class SysctlsStanza < ::Artifacts::Stanza

      def snippets =
        {
          'net.core.somaxconn': 1024
        }

    end
  end
end

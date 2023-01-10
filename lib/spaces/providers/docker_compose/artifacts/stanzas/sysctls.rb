module Artifacts
  module DockerCompose
    module Stanzas
      class Sysctls < Stanza

        def snippets =
          {
            'net.core.somaxconn': 1024
          }

      end
    end
  end
end

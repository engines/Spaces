module Artifacts
  module DockerCompose
    module Stanzas
      class Logging < Stanza

        def snippets =
          {
            driver: :syslog,
            options: {
              'syslog-address': "tcp://192.168.0.42:123"
            }
          }

      end
    end
  end
end

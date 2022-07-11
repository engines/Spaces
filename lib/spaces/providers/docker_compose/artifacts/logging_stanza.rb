module Artifacts
  module DockerCompose
    class LoggingStanza < ::Artifacts::Stanza

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

module Adapters
  module CloudFormation
    class Ports < ::Adapters::Ports

      def snippets =
        %(
          provisioner = "local-exec" {
            command = "#{commands}"
          }
        )

    end
  end
end

module Adapters
  module Terraform
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

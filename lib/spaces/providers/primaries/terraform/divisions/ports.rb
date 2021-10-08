module Divisions
  module Terraform
    class Ports < ::Divisions::Divisible

      def snippets
        %(
          provisioner = "local-exec" {
            command = "#{commands}"
          }
        )
      end

    end
  end
end

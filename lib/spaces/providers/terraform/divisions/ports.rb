module Divisions
  module Terraform
    class Ports < ::Divisions::Divisible

      def stanzas
        %(
          provisioner = "local-exec" {
            command = "#{commands}"
          }
        )
      end

    end
  end
end

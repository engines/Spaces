module Providers
  class Docker < ::Providers::Provider
    class Container < ::Providers::Container

      def blueprint_stanzas
        %(
          resource "docker_container" "#{blueprint_identifier}" {
            name  = "#{blueprint_identifier}"
            image = "#{image}"
          }
        )
      end

    end
  end
end

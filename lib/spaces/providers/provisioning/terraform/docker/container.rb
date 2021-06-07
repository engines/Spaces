module Providers
  class Docker < ::ProviderAspects::Provider
    class Container < ::ProviderAspects::Container

      def resolution_stanzas_for(_)
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

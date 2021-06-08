module Providers
  class Docker < ::ProviderAspects::Provider
    class Container < ::ProviderAspects::Container

      def resolution_stanzas_for(_)
        %(
          resource "#{container_type}" "#{blueprint_identifier}" {
            name      = "#{blueprint_identifier}"
            image     = "docker-server:#{image_name}"
        )
      end

    end
  end
end

module Providers
  class Docker < ::ProviderAspects::Provider
    class Container < ::ProviderAspects::Container

      def resolution_stanzas_for(_)
        %(
          resource "#{container_type}" "#{blueprint_identifier}" {
            name      = "#{blueprint_identifier}"
            image     = "#{spaces_image_registry}#{image_name}"

            #{connect_services_stanzas}
            #{device_stanzas}
          }
        )
      end

  	  def spaces_image_registry
        # "#{image_host}:" if image_host
      end

    end
  end
end

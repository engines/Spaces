module Providers
  class Docker < ::ProviderAspects::Provider
    class Volume < ::ProviderAspects::Volume

      def resolution_stanzas_for(_)
        %Q(
          volumes { 
            volume_name = "#{volume_name}"
			 container_path = "#{destination}"
          }
        )
      end

      def device_stanzas
        %Q(
          resource "docker_volume" "#{volume_name}"  {
            name = "#{volume_name}"
            driver = "local"           
          }
        )
      end
    end
  end
end

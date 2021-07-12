module Providers
  class Docker < ::ProviderAspects::Provider
    class Volume < ::ProviderAspects::Volume
      def device_stanzas
        %Q(
          resource "docker_volume" "#{volume_name}"  {
            name = "#{volume_name}"
            driver = "local"           
            mountpoint "#{destination}"
          }
        )
      end
    end
  end
end

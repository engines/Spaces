module Providers
  class Lxd < ::Divisions::Provider
    class Volume < ::Divisions::Volume

      def provisioning_stanzas
        %Q(
          resource "lxd_volume" "#{volume_name}" {
            name = "#{volume_name}"
            pool = "#{pool_name}"
          }
        )
      end

      def device_stanzas
        %Q(
          device {
            name = "#{volume_name}"
            type = "disk"
            properties = {
              path = "#{destination}"
              source = "#{volume_name}"
              pool = "#{pool_name}"
            }
          }
        )
      end

      def volume_name; "#{blueprint_identifier}-#{source}-volume" ;end
      def pool_name; "#{source}-pool" ;end

    end
  end
end

module Providers
  class Lxd < ::Divisions::Provider
    class Volume < ::Divisions::Volume

      def provisioning_stanzas
        %Q(
          resource "lxd_volume" "#{identifier}-#{source}-volume" {
            name = "#{identifier}-#{source}-volume"
            pool = "#{source}-pool"
          }
        )
      end

    end
  end
end

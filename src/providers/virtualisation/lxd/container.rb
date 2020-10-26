module Providers
  class Lxd < ::Divisions::Provider
    class Container < ::Divisions::Container


      def provisioning_stanzas
        scale do |i|
          %Q(
            resource "lxd_container" "#{identifier}-#{i}" {
              name      = "#{identifier}-#{i}"
              image     = "#{image_name}"
              ephemeral = false

              device {
                name  = "root"
                type  = "disk"

                properties  = {
                  "path" = "/"
                  "pool" = "default"
                }
              }

              config = {
                "boot.autostart" = true
              }
            }
          )
        end
      end

    end
  end
end

module Providers
  class Lxd < ::Divisions::Provider
    class Container < ::Divisions::Container

      def provisioning_stanzas
        scale do |i|
          container_stanza(i)
        end
      end

      def container_stanza(i)
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

              #{device_stanzas}

            config = {
              "boot.autostart" = true
            }
          }
        )
      end

      def device_stanzas
        emission.volumes.all.map(&:device_stanzas).join("\n") if emission.has?(:volumes)
      end

    end
  end
end

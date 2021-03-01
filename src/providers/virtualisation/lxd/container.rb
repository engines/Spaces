module Providers
  class Lxd < ::Providers::Provider
    class Container < ::Providers::Container

      def blueprint_stanzas
        %(
          resource "#{resource_name}" "#{blueprint_identifier}" {
            name      = "#{blueprint_identifier}"
            image     = "local-lxd-server:#{image_name}"
            ephemeral = false
            profiles = ["default"]

            device {
              name  = "root"
              type  = "disk"

              properties  = {
                "path" = "/"
                "pool" = "default"
              }
            }

            provisioner "local-exec" {
              command = "lxc exec #{blueprint_identifier} /root/setup.sh"
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
end

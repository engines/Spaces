module Providers
  class Lxd < ::Providers::Provider
    class Container < ::Providers::Container

      def blueprint_stanzas
        scale do |i|
          container_stanza(i)
        end
      end

      def container_stanza(i)
        ci = container_identifier_for(i+1)

        %(
          resource "lxd_container" "#{ci}" {
            name      = "#{ci}"
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
              command = "lxc exec #{ci} /root/setup.sh"
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

      def container_identifier_for(postfix)
        "#{blueprint_identifier}-#{postfix}"
      end

    end
  end
end

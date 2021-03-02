module Providers
  class Lxd < ::Providers::Provider
    class Container < ::Providers::Container

      def blueprint_stanzas_for(_)
        %(
          resource "#{resource_type}" "#{blueprint_identifier}" {
            name      = "#{blueprint_identifier}"
            image     = "local-lxd-server:#{image_name}"
            ephemeral = false
            profiles = ["default"]

            #{dependency_stanza}

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

      def dependency_stanza
        %(depends_on=[#{dependency_string}]) if connections.any?
      end

      def device_stanzas
        emission.volumes.all.map(&:device_stanzas).join("\n") if emission.has?(:volumes)
      end

      def dependency_string
        connections.map { |c| "#{resource_type}.#{c.identifier}" }.join(', ')
      end

      def resource_type; "#{type}_#{qualifier}" ;end

    end
  end
end

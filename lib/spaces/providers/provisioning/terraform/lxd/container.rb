module Providers
  class Lxd < ::ProviderAspects::Provider
    class Container < ::ProviderAspects::Container

      def resolution_stanzas_for(_)
        %(
          resource "#{container_type}" "#{blueprint_identifier}" {
            name      = "#{blueprint_identifier}"
            image     = "lxd-server:#{image_name}"
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

            #{connect_services_stanzas}
            #{ports_stanzas}
            #{commissioning_stanzas}
            #{device_stanzas}

            config = {
              "boot.autostart" = true
            }
          }
        )
      end

      def dependency_stanza
        %(depends_on=[#{dependency_string}]) if connections_down.any?
      end

      def commissioning_stanzas
        commissioning_scripts.map do |s|
          %(
            provisioner "local-exec" {
              command = "lxc exec #{blueprint_identifier} #{s}"
            }
          )
        end.join
      end

      def ports_stanzas
        provisions.ports.stanzas if provisions.has?(:ports)
      end

      def dependency_string
        connections_down.map { |c| "#{container_type}.#{c.blueprint_identifier}" }.join(', ')
      end

    end
  end
end

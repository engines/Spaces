module Artifacts
  module Terraform
    module Lxd
      class ServiceStanza < ::Artifacts::Stanza

        def snippets_for(_)
          %(
            resource "#{container_type}" "#{blueprint_identifier}" {
              name      = "#{blueprint_identifier}"
              image     = "lxd-server:#{image_identifier}"
              ephemeral = false
              profiles = ["default"]

              #{dependency_snippet}

              device {
                name  = "root"
                type  = "disk"

                properties  = {
                  "path" = "/"
                  "pool" = "default"
                }
              }

              #{connect_services_snippets}
              #{ports_snippets}
              #{commissioning_snippets}
              #{device_snippets}

              config = {
                "boot.autostart" = true
              }
            }
          )
        end

        def dependency_snippet
          %(depends_on=[#{dependency_string}]) if connections_down.any?
        end

        def commissioning_snippets
          commissioning_scripts.map do |s|
            %(
              provisioner "local-exec" {
                command = "lxc exec #{blueprint_identifier} #{s}"
              }
            )
          end.join
        end

        def ports_snippets
          orchestration.ports.snippets if orchestration.has?(:ports)
        end

        def dependency_string
          connections_down.map { |c| "#{container_type}.#{c.blueprint_identifier}" }.join(', ')
        end

      end
    end
  end
end

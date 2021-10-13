module Providers
  module Terraform
    module Docker
      class ContainerStanza < ::Artifacts::Stanza

        def snippets_for(_)
          %(
            resource "#{container_type}" "#{blueprint_identifier}" {
              name = "#{blueprint_identifier}"
              image = "#{spaces_image_registry}#{image_name}"
              domainname = "#{universe.host}"
              hostname = "#{blueprint_identifier}"

              #{connect_services_snippets}
              #{device_snippets}
            }
          )
        end

        def spaces_image_registry
          # "#{image_host}:" if image_host
        end

        def dependency_string
          connections_down.map { |c| "#{container_type}.#{c.blueprint_identifier}" }.join(', ')
        end
      end

    end
  end
end

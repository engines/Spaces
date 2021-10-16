module Artifacts
  module Terraform
    class ContainerStanza < ::Artifacts::Stanza

      def snippets
        %(
          resource "#{runtime_qualifier}" "#{blueprint_identifier}" {
            name = "#{blueprint_identifier}"
            image = "#{spaces_image_registry}#{image_name}"
            domainname = "#{universe.host}"
            hostname = "#{blueprint_identifier}"

            #{connect_services_snippets}
            #{device_snippets}
          }
        )
      end

      def connect_services_snippets
        connect_bindings.map do |c|
          r = c.resolution
          if r.has?(:service_tasks)
            # r.service_tasks.connection_snippet_for(c) TODO: FIX!
          end
        end.compact.join
      end

      def device_snippets
        # volumes.all.map(&:container_snippets).join TODO: FIX!
      end

      def spaces_image_registry
        # "#{image_host}:" if image_host
      end

      def dependency_string
        connections_down.map { |c| "#{runtime_qualifier}.#{c.blueprint_identifier}" }.join(', ')
      end
    end

  end
end

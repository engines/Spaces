module Providers
  class Docker < ::Divisions::Provider
    class Container < ::Divisions::Container

      def provisioning_stanzas
        scale do |i|
          %Q(
            resource "docker_container" "#{blueprint_identifier}-#{i}" {
              name  = "#{blueprint_identifier}-#{i}"
              image = "#{image}"
            }
          )
        end
      end

    end
  end
end

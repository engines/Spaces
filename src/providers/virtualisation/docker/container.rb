module Providers
  class Docker < ::Providers::Provider
    class Container < ::Providers::Container

      def blueprint_stanzas
        scale do |i|
          %Q(
            resource "docker_container" "#{blueprint_identifier}-#{i+1}" {
              name  = "#{blueprint_identifier}-#{i+1}"
              image = "#{image}"
            }
          )
        end
      end

    end
  end
end

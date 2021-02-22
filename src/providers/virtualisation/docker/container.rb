module Providers
  class Docker < ::Divisions::Provider
    class Container < ::Divisions::Container

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

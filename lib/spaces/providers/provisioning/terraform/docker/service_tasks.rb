module Providers
  class Docker < ::ProviderAspects::Provider
    class ServiceTasks < ::ProviderAspects::ServiceTasks

      def connection_stanza_for(binding)
        connect&.map do |c|
          %(
            provisioner "local-exec" {
              command = "docker #{binding.environment_variables} exec #{blueprint_identifier} #{c} "
            }
          )
        end.join
      end

    end
  end
end

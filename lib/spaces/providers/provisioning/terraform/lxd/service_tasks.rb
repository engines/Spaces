module Providers
  class Lxd < ::ProviderAspects::Provider
    class ServiceTasks < ::ProviderAspects::ServiceTasks

      def connection_stanza_for(binding)
        connect&.map do |c|
          %(
            provisioner "local-exec" {
              command = "lxc exec #{blueprint_identifier} #{binding.environment_variables} #{c}"
            }
          )
        end.join
      end

    end
  end
end

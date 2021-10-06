module Providers
  module Terraform
    module Docker
      class ServiceTasks < ::ProviderAspects::ServiceTasks

        def connection_stanza_for(binding)
          connect&.map do |c|
            %(
              provisioner "local-exec" {
                command = "docker exec #{binding.environment_variables}  #{blueprint_identifier} #{c} "
              }
            )
          end.join
        end

      end
    end
  end
end

module Providers
  module Terraform
    module Docker
      class ServiceTasks < ::Adapters::ServiceTasks

        def connection_snippet_for(binding)
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

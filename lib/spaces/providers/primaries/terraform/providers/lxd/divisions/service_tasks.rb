module Providers
  module Terraform
    module Lxd
      class ServiceTasks < ::Adapters::ServiceTasks

        def connection_snippet_for(binding)
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
end

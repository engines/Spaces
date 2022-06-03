module Artifacts
  module Terraform
    module Aws
      module TaskDefining

        def configuration_hash
          super.without(*task_definition_keys)
        end

        def task_definition_keys
          [
            :cpu,
            :memory,
            :essential,
            :container_port,
            :host_port
          ]
        end

      end
    end
  end
end

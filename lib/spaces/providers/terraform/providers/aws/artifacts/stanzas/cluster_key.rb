require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class ClusterKeyStanza < ResourceStanza

        def default_configuration =
          super.merge(
            description: resource_identifier,
      			deletion_window_in_days: 10,
      			is_enabled: true,
      			enable_key_rotation: false,
      			multi_region: false
          )

      end
    end
  end
end

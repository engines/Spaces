require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class ClusterKeyStanza < ResourceStanza

        def default_configuration
          OpenStruct.new(
            description: application_identifier,
      			deletion_window_in_days: 10,
      			is_enabled: true,
      			enable_key_rotation: false,
      			multi_region: false
          )
        end

      end
    end
  end
end

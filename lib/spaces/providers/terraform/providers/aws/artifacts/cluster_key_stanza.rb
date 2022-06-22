module Artifacts
  module Terraform
    module Aws
      class ClusterKeyStanza < CapsuleStanza

        def default_configuration
          OpenStruct.new(
            description: '^^identifier^^',
      			deletion_window_in_days: 10,
      			is_enable: true,
      			enable_key_rotation: false,
      			multi_region: false
          )
        end

      end
    end
  end
end

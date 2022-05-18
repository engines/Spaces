require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class ClusterKeyStanza < CapsuleStanza

        def resource_type; :kms_key ;end

      end
    end
  end
end

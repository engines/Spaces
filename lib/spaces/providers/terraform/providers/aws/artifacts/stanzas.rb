module Artifacts
  module Terraform
    module Aws

      class KmsStanza < CapsuleStanza ;end
      class ClusterKeyStanza < CapsuleStanza ;end
      class ContainerDefinitionStanza < CapsuleStanza ;end
      class InternetGatewayStanza < CapsuleStanza ;end
      class SubnetStanza < CapsuleStanza ;end
      class TaskDefinitionStanza < CapsuleStanza ;end
      class VpcStanza < CapsuleStanza ;end

    end
  end
end

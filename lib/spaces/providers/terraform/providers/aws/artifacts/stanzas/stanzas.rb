module Artifacts
  module Terraform
    module Aws

      class LogGroupStanza < ::Artifacts::Aws::LogGroupStanza ;end
      class ContainerDefinitionStanza < ::Artifacts::Aws::ContainerDefinitionStanza ;end

      class ClusterKeyStanza < ::Artifacts::Aws::ClusterKeyStanza
        def name_snippet = nil
      end

      class ContainerServiceClusterStanza < ::Artifacts::Aws::ContainerServiceClusterStanza ;end

      class VpcStanza < ::Artifacts::Aws::VpcStanza
        def name_snippet = nil
      end

    end
  end
end

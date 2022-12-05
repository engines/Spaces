require_relative 'resource'

module Artifacts
  module Aws
    class ContainerServiceClusterStanza < ResourceStanza

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::ContainerServiceCluster.new(self)
      end

    end
  end
end

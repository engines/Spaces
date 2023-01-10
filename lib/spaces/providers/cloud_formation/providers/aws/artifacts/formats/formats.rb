require_relative 'hash'

module Artifacts
  module CloudFormation
    module Aws
      module Formats

        # TODO: REFACTOR abstract up
        class LogGroup < Hash ;end
        class ContainerDefinition < Hash ;end

        class ClusterKey < Hash
          def name_snippet = nil
        end

        class ContainerServiceCluster < Hash
          def tags_snippet = nil
        end

        class Vpc < Hash
          def name_snippet = nil
        end

      end
    end
  end
end

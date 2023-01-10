require_relative 'hcl'

module Artifacts
  module Terraform
    module Aws
      module Formats

        # TODO: REFACTOR abstract up
        class LogGroup < Hcl ;end
        class ContainerDefinition < Hcl ;end

        class ClusterKey < Hcl
          def name_snippet = nil
        end

        class ContainerServiceCluster < Hcl
          def tags_snippet = nil
        end

        class Vpc < Hcl
          def name_snippet = nil
        end

      end
    end
  end
end

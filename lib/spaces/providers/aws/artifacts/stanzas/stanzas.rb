require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas

      class ContainerDefinition < Resource ;end
      class ContainerServiceCluster < Resource ;end
      class IamRole < Resource ;end
      class LogGroup < Resource ;end

      class Providers < Stanza
        def resource_type = :provider
      end

    end
  end
end

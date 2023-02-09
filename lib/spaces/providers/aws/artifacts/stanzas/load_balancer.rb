require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class LoadBalancer < Resource

        delegate(resources_by: :arena)

        def more_snippets_keys = [:subnets, :security_groups]

        def default_configuration =
          super.merge(
            subnets: default_subnets,
            security_groups: default_security_groups
          )

        def default_subnets =
          resources_by(:subnet).select { |s| s.configuration.public }.map(&:identifier)

        def default_security_groups =
          resources_by(:security_group).map(&:identifier)

        def more_snippets_keys = [:subnets, :security_groups]

      end
    end
  end
end

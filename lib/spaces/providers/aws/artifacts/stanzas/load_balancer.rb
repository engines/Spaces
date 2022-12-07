require_relative 'resource'

module Artifacts
  module Aws
    module Stanzas
      class LoadBalancer < Resource

        delegate(resources_by: :arena)

        def more_snippets_keys = [:subnets, :security_groups]

        def subnet_identifiers = subnet_array.map { |s| "#{s}.id" }
        def security_group_identifiers = security_group_array.map { |g| "#{g}.id" }

        def dependency_array = [security_group_array, subnet_array].flatten

        def subnet_array =
          configuration.subnets.map do |s|
            "aws_subnet.#{arena_resource_qualification_for(s)}"
          end

        def security_group_array =
          configuration.security_groups.map do |s|
            "aws_security_group.#{arena_resource_qualification_for(s)}"
          end

        def default_configuration =
          super.merge(
            subnets: default_subnets,
            security_groups: default_security_groups
          )

        def default_subnets =
          resources_by(:subnet).select { |s| s.configuration.public }.map(&:identifier)

        def default_security_groups =
          resources_by(:security_group).map(&:identifier)

      end
    end
  end
end

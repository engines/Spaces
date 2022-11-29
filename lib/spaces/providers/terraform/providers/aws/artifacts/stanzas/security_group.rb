require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class SecurityGroupStanza < ResourceStanza
        include Named

        def more_snippets = SecurityGroup::More.new(self).content

        def more_configuration =
          {
            description: resource_identifier,
            vpc_binding: :vpc,
            in_from_port: 0,
            in_to_port: '',
            in_protocol: '',
            in_cidr_blocks: [],

            out_from_port: 0,
            out_to_port: 0,
            out_protocol: '-1',
            out_cidr_blocks: ['0.0.0.0/0'],
            out_ipv6_cidr_blocks: ['::/0']
          }

        def in_ivp6
          %(configuration.in_ipv6_cidr_blocks #{configuration.in_ipv6_cidr_blocks}) if configuration.in_ipv6_cidr_blocks
        end

      end
    end
  end
end

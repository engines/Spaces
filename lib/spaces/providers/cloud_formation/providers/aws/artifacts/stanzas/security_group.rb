require_relative 'resource'

module Artifacts
  module CloudFormation
    module Aws
      class SecurityGroupStanza < ResourceStanza
        include Named

        def more_snippets =
          %(
            vpc_id = aws_vpc.#{qualification_for(:vpc_binding)}.id
            ingress {
              from_port        = #{configuration.in_from_port}
              to_port          = #{configuration.in_to_port}
              protocol         = "#{configuration.in_protocol}"
              cidr_blocks      = #{configuration.in_cidr_blocks}
              #{in_ivp6}
            }

            egress {
              from_port        = #{configuration.out_from_port}
              to_port          = #{configuration.out_to_port}
              protocol         = "#{configuration.out_protocol}"
              cidr_blocks      = #{configuration.out_cidr_blocks}
              ipv6_cidr_blocks = #{configuration.out_ipv6_cidr_blocks}
            }
          )

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

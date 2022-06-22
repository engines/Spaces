require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < ResourceStanza

        def configuration_snippet
          %(
            vpc_id = aws_vpc.#{configuration.vpc_binding}.id
          )
        end

        def more_snippets
          arena.compute_resolutions_for(:subnet).map do |r|
            route_snippet_for(r)
          end.join("\n")
        end

        def route_snippet_for(subnet_resolution)
          %(
            route {
              cidr_block = "#{subnet_resolution.configuration.cidr_block}"
              gateway_id = aws_internet_gateway.#{configuration.gateway_binding}.id
            }
          )
        end

        def configuration_hash
          super.without(:vpc_binding, :gateway_binding)
        end

        def default_configuration
          OpenStruct.new(
            vpc_binding: :vpc,
            gateway_binding: :'internet-gateway'
          )
        end

      end
    end
  end
end

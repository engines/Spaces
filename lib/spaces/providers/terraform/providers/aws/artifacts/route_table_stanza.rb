require_relative 'capsule_stanza'

module Artifacts
  module Terraform
    module Aws
      class RouteTableStanza < CapsuleStanza

        def more_snippets
          arena.compute_resolutions_for(:subnet).map do |r|
            route_snippet_for(r)
          end.join("\n")
        end

        def route_snippet_for(subnet_resolution)
          %(
            route {
              cidr_block = "#{subnet_resolution.configuration.cidr_block}"
              gateway_id = configuration.gateway_id
            }
          )
        end

        def configuration_hash
          super.without(:gateway_id)
        end

      end
    end
  end
end

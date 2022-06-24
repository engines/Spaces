require_relative 'resource_stanza'

module Artifacts
  module Terraform
    module Aws
      class ApplicationLoadBalancerStanza < ResourceStanza

        def more_snippets
          %(
            internal           = false
            load_balancer_type = "application"
            subnets            = aws_subnet.public.*.id
            security_groups    = [aws_security_group.load_balancer_security_group.id]
          )
        end

      end
    end
  end
end

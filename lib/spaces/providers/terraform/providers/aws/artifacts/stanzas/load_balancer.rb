module Artifacts
  module Terraform
    module Aws
      class LoadBalancerStanza < ::Artifacts::Aws::LoadBalancerStanza

        def more_snippets = LoadBalancer::More.new(self).content

      end
    end
  end
end

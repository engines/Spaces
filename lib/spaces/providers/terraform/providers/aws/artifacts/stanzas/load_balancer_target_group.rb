module Artifacts
  module Terraform
    module Aws
      class LoadBalancerTargetGroupStanza < ::Artifacts::Aws::LoadBalancerTargetGroupStanza

        def more_snippets = LoadBalancer::TargetGroup.new(self).content

      end
    end
  end
end

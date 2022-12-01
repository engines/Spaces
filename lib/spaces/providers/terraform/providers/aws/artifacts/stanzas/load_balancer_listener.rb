module Artifacts
  module Terraform
    module Aws
      class LoadBalancerListenerStanza < ::Artifacts::Aws::LoadBalancerListenerStanza

        def more_snippets = LoadBalancer::Listener.new(self).content

      end
    end
  end
end

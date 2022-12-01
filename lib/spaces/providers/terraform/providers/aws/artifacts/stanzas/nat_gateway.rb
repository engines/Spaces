module Artifacts
  module Terraform
    module Aws
      class NatGatewayStanza < ::Artifacts::Aws::NatGatewayStanza

        def more_snippets = NatGateway::More.new(self).content

      end
    end
  end
end

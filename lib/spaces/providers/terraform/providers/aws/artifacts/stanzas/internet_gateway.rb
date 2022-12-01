module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < ::Artifacts::Aws::InternetGatewayStanza

        def more_snippets = InternetGateway::More.new(self).content

      end
    end
  end
end

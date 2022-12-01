module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < ::Artifacts::Aws::InternetGatewayStanza

        def name_snippet = nil
        def more_snippets = InternetGateway::More.new(self).content

      end
    end
  end
end

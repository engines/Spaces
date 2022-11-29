require_relative 'resource'

module Artifacts
  module Terraform
    module Aws
      class InternetGatewayStanza < ResourceStanza

        class << self
          def default_configuration =
            super.merge(
              vpc_binding: :vpc
            )
        end

        def more_snippets = InternetGateway::More.new(self).content

      end
    end
  end
end

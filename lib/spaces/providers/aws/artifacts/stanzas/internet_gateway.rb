require_relative 'resource'

module Artifacts
  module Aws
    class InternetGatewayStanza < ResourceStanza

      class << self
        def default_configuration =
          super.merge(
            vpc_binding: :vpc
          )
      end

      def format
        @format ||= ::Artifacts::Terraform::Aws::Formats::InternetGateway.new(self)
      end

    end
  end
end

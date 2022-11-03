module Providers
  module Aws
    class Aws < ::Providers::Provider

      def image_registry_domain =
        "#{account_identifier}.dkr.ecr.#{region}.amazonaws.com"

    end
  end
end

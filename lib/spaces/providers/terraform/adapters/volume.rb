module Adapters
  module Terraform
    class Volume < ::Adapters::Volume

      def volume_name = "#{resource_identifier}-#{source}"
      def pool_name = "#{source}-pool"

    end
  end
end

module Adapters
  module Terraform
    class Volume < ::Adapters::Volume

      def volume_name = "#{application_identifier.hyphenated}-#{source}"
      def pool_name = "#{source}-pool"

    end
  end
end

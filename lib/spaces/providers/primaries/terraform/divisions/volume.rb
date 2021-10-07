module Providers
  module Terraform
    class Volume < ::Adapters::Volume

      def device_stanzas; ;end

      # TERRAFORM SPECIFIC
      def volume_name; "#{blueprint_identifier.hyphenated}-#{source}" ;end
      def pool_name; "#{source}-pool" ;end

    end
  end
end

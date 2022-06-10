module Adapters
  module Terraform
    class Volume < ::Adapters::Volume

      def volume_name; "#{application_identifier.hyphenated}-#{source}" ;end
      def pool_name; "#{source}-pool" ;end

    end
  end
end

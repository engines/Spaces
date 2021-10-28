module Artifacts
  module Terraform
    class ZonesStanza < ::Artifacts::Stanza

      def stanza_qualifiers
        [provider.dns_qualifier]
      end

      def stanza_class_for(qualifier)
        class_for(nesting_elements, qualifier, :zone_stanza)
      end

    end
  end
end

require_relative '../stanza'

module Terraform
  module Stanzas
    class Consul < ::Terraform::Stanza

      def declaratives
        %Q(
          provider "#{identifier}" {
            address = "#{address}"
            # datacenter = "#{datacenter_identifier || 'any'}"
          }
        )
      end

      def identifier; 'consul' ;end

      def address
        "#{['consul', datacenter_identifier, universe.host].compact.join('.')}:#{port}"
      end

      def datacenter_identifier; ;end
      def port; 8500 ;end

    end
  end
end

require_relative '../stanza'

module Terraform
  module Stanzas
    class Consul < ::Terraform::Stanza

      def declaratives
        %Q(
          provider "#{identifier}" {
            address = "#{address}"
            # datacenter = "any"
          }
        )
      end

      def identifier; 'consul' ;end

      def address
        "#{['consul', universe.host].join('.')}:#{port}"
      end

      def port; 8500 ;end

    end
  end
end

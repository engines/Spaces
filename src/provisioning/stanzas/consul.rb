require_relative '../stanza'

module Provisioning
  module Stanzas
    class Consul < Stanza

      def declaratives
        %Q(
          provider "#{qualifier}" {
            address = "#{address}"
            # datacenter = "any"
          }
        )
      end

      def address
        "#{[qualifier, universe.host].join('.')}:#{port}"
      end

      def port; 8500 ;end

    end
  end
end

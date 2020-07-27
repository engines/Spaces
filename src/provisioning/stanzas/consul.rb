require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Consul < ::Releases::Stanza

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

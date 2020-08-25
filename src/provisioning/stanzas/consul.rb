require_relative '../../releases/stanza'

module Provisioning
  module Stanzas
    class Consul < ::Releases::Stanza

      def declaratives
        %Q(
          provider "#{qualifier}" {
            address = "#{address}"
            datacenter = "#{data_center.identifier}"
          }
        )
      end

      def address
        "#{[qualifier, universe.host].join('.')}:#{port}"
        # "localhost:#{port}"
      end

      def data_center
        universe.data_centers.default
      end

      def port; 8500 ;end

    end
  end
end

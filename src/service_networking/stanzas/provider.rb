require_relative '../../releases/stanza'

module ServiceNetworking
  module Stanzas
    class Provider < ::Releases::Stanza


      def declaratives
        q
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

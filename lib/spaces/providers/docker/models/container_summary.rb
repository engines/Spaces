require_relative 'model'

module Providers
  module Docker
    class ContainerSummary < Model

      def summary
        @summary ||= {
          identifier: identifier,
          image_identifier: image_identifier,
          spaces_identifier: spaces_identifier,
          name: name,
          status: state
        }
      end

      def spaces_identifier
        names.first[1..-1].gsub(/_*\d/, '').as_compound('_')
      end

      def identifier; id[0..11] ;end
      def image_identifier; image_id[7..18] ;end
      def name; names.first[1..-1] ;end

      def ip_address; network.ip_address ;end

      def network
        # TODO: revise hackiness -- assumes the first network value is the only or best
        k = (n = network_settings.networks).keys.first
        n.send(k)
      end

    end
  end
end

require_relative 'model'

module Providers
  module Docker
    class CapsuleSummary < Model

      def summary
        @summary ||= OpenStruct.new(
          runtime: runtime_qualifier,
          status: state,
          resolution_identifier: resolution_identifier,
          arena_identifier: arena_identifier,
          blueprint_identifier: blueprint_identifier,
          identifier: identifier,
          image_identifier: image_identifier,
          name: name
        )
      end

      def resolution_identifier
        names.first[1..-1].gsub(/_*\d/, '').as_compound('_')
      end

      def arena_identifier; resolution_identifier.high ;end
      def blueprint_identifier; resolution_identifier.low ;end

      def runtime_qualifier; name_elements[1].snakize ;end

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

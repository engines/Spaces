require_relative 'model'

module Providers
  module Docker
    class CapsuleSummary < Model

      def summary =
        @summary ||= super.merge(
          image_identifier: image_identifier,
          name: name,
          status: state,
        )

      def resolution_identifier =
        names.first[1..-1].gsub(/_*\d/, '').as_compound('_')

      def identifier = id[0..11]
      def image_identifier = image_id[7..18]
      def name = names.first[1..-1]

      def ip_address = network.ip_address

      def network
        # TODO: revise hackiness -- assumes the first network value is the only or best
        k = (n = network_settings.networks).keys.first
        n.send(k)
      end

    end
  end
end

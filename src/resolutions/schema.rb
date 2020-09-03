require_relative '../releases/schema'
require_relative '../clients/client'

module Resolutions
  class Schema < ::Releases::Schema

    class << self
      def associative_classes
        [
          Clients::Client,
          DataCenters::DataCenter
        ]
      end

      def component_classes
        [
        ]
      end

      def associative_divisions; @associative_divisions ||= map_for(associative_classes) ;end
      def component_divisions; @component_divisions ||= map_for(component_classes) ;end

      def mandatory_divisions; @mandatory_divisions ||= component_divisions.merge(associative_divisions) ;end
      def mandatory_keys; mandatory_divisions.keys ;end

      def divisions; mandatory_divisions.merge(super) ;end

    end

    delegate(mandatory_keys: :klass)

  end
end

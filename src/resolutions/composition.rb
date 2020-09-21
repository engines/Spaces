require_relative '../emitting/emissions/composition'
require_relative '../clients/client'
require_relative '../domains/domain'

module Resolutions
  class Composition < ::Emitting::Composition

    class << self
      def associative_classes
        [
          Clients::Client,
          Domains::Domain
        ]
      end

      def auxiliary_classes
        [
        ]
      end

      def associative_divisions; @associative_divisions ||= map_for(associative_classes) ;end
      def auxiliary_divisions; @auxiliary_divisions ||= map_for(auxiliary_classes) ;end

      def mandatory_divisions; @mandatory_divisions ||= auxiliary_divisions.merge(associative_divisions) ;end
      def mandatory_keys; mandatory_divisions.keys ;end

      def divisions; mandatory_divisions.merge(super) ;end

    end

    delegate(mandatory_keys: :klass)

  end
end

require_relative '../emitting/emissions/composition'
require_relative 'associations/clients/client'
require_relative 'associations/domains/domain'

module Resolving
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Clients::Client,
          Domains::Domain
        ]
      end

      def associative_divisions
        @associative_divisions ||= map_for(associative_classes)
      end

      def mandatory_keys
        associative_divisions.keys
      end

      def divisions
        associative_divisions.merge(super)
      end

    end

    delegate(mandatory_keys: :klass)

  end
end

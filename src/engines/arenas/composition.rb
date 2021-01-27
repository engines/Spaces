module Arenas
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Associations::Tenant,
          Associations::Domain,
          Associations::Dns
        ]
      end

      def divisions; @divisions ||= map_for(associative_classes) ;end

      def mandatory_keys; divisions.keys ;end
    end

    delegate(mandatory_keys: :klass)

  end
end

module Resolving
  class Composition < ::Emissions::Composition

    class << self
      def associative_classes
        [
          Clients::Client,
          Domains::Domain
        ]
      end
    end

  end
end

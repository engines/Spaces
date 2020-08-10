require_relative '../spaces/schema'

module Inclusions
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          all: [
            (1..),
            {
              identifier: 0,
              descriptor: 1
            }
          ]
        }
      end
    end

  end
end

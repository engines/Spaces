require_relative '../spaces/schema'

module Bindings
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          all: [
            (1..),
            {
              identifier: 1,
              descriptor: 1,
              persistent: [(0..), directories: (0..), files: (0..)]
            }
          ]
        }
      end
    end

  end
end

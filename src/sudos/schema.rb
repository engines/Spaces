require_relative '../spaces/schema'

module Sudos
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          runtime: (0..),
          install: (0..)
        }
      end
    end

  end
end

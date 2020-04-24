require_relative '../spaces/schema'

module Replacements
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { all: [(1..), { string: 1, source: 1, destination: 1 }] }
      end
    end

  end
end

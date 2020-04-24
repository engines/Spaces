require_relative '../spaces/schema'

module Packages
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { all: [(1..), { descriptor: 1, }] }
      end
    end

  end
end

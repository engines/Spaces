require_relative '../spaces/schema'

module Repositories
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { all: [(1..), { descriptor: 1 }] }
      end
    end

  end
end

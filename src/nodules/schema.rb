require_relative '../spaces/schema'

module Nodules
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { all: [(1..), { name: 1, type: 1 }] }
      end
    end

  end
end

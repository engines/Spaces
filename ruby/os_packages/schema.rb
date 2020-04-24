require_relative '../spaces/schema'

module OsPackages
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { all: [(1..), { name: 1 }] }
      end
    end

  end
end

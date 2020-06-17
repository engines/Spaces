require_relative '../spaces/schema'

module WritePermissions
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { all: [(1..), { path: 1, recursive: 0 }] }
      end
    end

  end
end

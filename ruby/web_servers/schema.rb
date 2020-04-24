require_relative '../spaces/schema'

module WebServers
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { identifier: 1, root_directory: 1 }
      end
    end

  end
end

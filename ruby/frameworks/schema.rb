require_relative '../spaces/schema'

module Frameworks
  class Schema < ::Spaces::Schema

    class << self
      def outline
        { identifier: 1, web_server: 1 }
      end
    end

  end
end

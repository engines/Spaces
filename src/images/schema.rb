require_relative '../spaces/schema'

module Images
  class Schema < ::Spaces::Schema

    class << self
      def outline
        {
          identifier: 0,
          platform: 0,
          name: 1,
          tag: 1
        }
      end
    end

  end
end

require_relative '../framework/model'
require_relative '../blueprint/space'
require_relative '../persistence/space'

module Universal
  class Space < ::Framework::Model
    # The aggregation of all spaces

    class << self
      def blueprint
        @@blueprint ||= Blueprint::Space.new
      end

      def persistence
        @@persistence ||= Persistence::Space.new
      end
    end

  end
end

require_relative '../framework/space'
require_relative '../blueprint/space'
require_relative '../persistence/space'

module Universal
  class Space < ::Framework::Space
    # The aggregation of all spaces

    class << self
      def blueprint
        @@blueprint ||= Blueprint::Space.new
      end

      def persistence
        @@persistence ||= Persistence::Space.new
      end
    end

    def path
      "/opt/engines/#{identifier}"
    end
  end
end

require_relative '../framework/space'
require_relative '../container/space'
require_relative '../blueprint/space'
require_relative '../persistence/space'

module Universal
  class Space < ::Framework::Space
    # The aggregation of all spaces

    class << self
      def container
        @@container ||= Container::Space.new
      end

      def blueprint
        @@blueprint ||= Blueprint::Space.new
      end

      def persistence
        @@persistence ||= Persistence::Space.new
      end
    end

    def container
      self.class.container
    end

    def blueprint
      self.class.blueprint
    end

    def persistence
      self.class.persistence
    end

    def path
      "/opt/engines/#{identifier}"
    end
  end
end

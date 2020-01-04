require_relative '../spaces/space'
require_relative '../container/space'
require_relative '../framework/space'
require_relative '../environment/space'
require_relative '../blueprint/space'
require_relative '../persistence/space'

module Universal
  class Space < ::Spaces::Space
    # The aggregation of all spaces

    class << self
      def containers
        @@containers ||= Container::Space.new
      end

      def frameworks
        @@frameworks ||= Framework::Space.new
      end

      def environments
        @@environments ||= Environment::Space.new
      end

      def blueprints
        @@blueprints ||= Blueprint::Space.new
      end

      def persistence
        @@persistence ||= Persistence::Space.new
      end
    end

    def containers
      self.class.containers
    end

    def frameworks
      self.class.frameworks
    end

    def environments
      self.class.environments
    end

    def blueprints
      self.class.blueprints
    end

    def persistence
      self.class.persistence
    end

    def path
      "/opt/engines/#{identifier}"
    end
  end
end

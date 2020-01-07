require_relative '../spaces/space'
require_relative '../container/space'
require_relative '../framework/space'
require_relative '../environment/space'
require_relative '../domain/space'
require_relative '../blueprint/space'
require_relative '../outer/space'

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

      def domains
        @@domains ||= Domain::Space.new
      end

      def blueprints
        @@blueprints ||= Blueprint::Space.new
      end

      def outer
        @@outer ||= Outer::Space.new
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

    def domains
      self.class.domains
    end

    def blueprints
      self.class.blueprints
    end

    def outer
      self.class.outer
    end

    def path
      "/opt/engines/#{identifier}"
    end
  end
end

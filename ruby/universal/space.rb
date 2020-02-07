require_relative '../spaces/space'
require_relative '../containers/space'
require_relative '../images/space'
require_relative '../frameworks/space'
require_relative '../nodules/space'
require_relative '../environments/space'
require_relative '../domains/space'
require_relative '../blueprints/space'
require_relative '../outer/space'

module Universal
  class Space < ::Spaces::Space
    # The aggregation of all spaces

    class << self
      def containers
        @@containers ||= Container::Space.new
      end

      def images
        @@image_space ||= Image::Space.new
      end

      def frameworks
        @@frameworks ||= Framework::Space.new
      end

      def nodules
        @@nodules ||= Nodule::Space.new
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

    def images
      self.class.images
    end

    def frameworks
      self.class.frameworks
    end

    def nodules
      self.class.nodules
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

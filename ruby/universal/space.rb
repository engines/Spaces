require_relative '../spaces/space'
require_relative '../containers/space'
require_relative '../installations/space'
require_relative '../images/space'
require_relative '../frameworks/space'
require_relative '../web_servers/space'
require_relative '../nodules/space'
require_relative '../environments/space'
require_relative '../domains/space'
require_relative '../users/space'
require_relative '../blueprints/space'
require_relative '../outer/space'

module Universal
  class Space < ::Spaces::Space

    class << self
      def containers
        @@containers ||= Containers::Space.new
      end

      def installations
        @@installations ||= Installations::Space.new
      end

      def images
        @@image_space ||= Images::Space.new
      end

      def frameworks
        @@frameworks ||= Frameworks::Space.new
      end

      def web_servers
        @@web_servers ||= WebServers::Space.new
      end

      def nodules
        @@nodules ||= Nodules::Space.new
      end

      def environments
        @@environments ||= Environments::Space.new
      end

      def domains
        @@domains ||= Domains::Space.new
      end

      def blueprints
        @@blueprints ||= Blueprints::Space.new
      end

      def users
        @@users ||= Users::Space.new
      end

      def outer
        @@outer ||= Outer::Space.new
      end
    end

    delegate([
      :containers,
      :installations,
      :images,
      :frameworks,
      :web_servers,
      :nodules,
      :environments,
      :domains,
      :users,
      :blueprints,
      :outer
    ] => :klass)

    def path
      "/opt/engines/#{identifier}"
    end

    def host
      'engines.internal'
    end
  end
end

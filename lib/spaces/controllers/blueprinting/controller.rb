module Blueprinting
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :blueprints ;end

      def method_class_map
        @method_class_map ||= super.merge({
          relations: ::Blueprinting::Commands::Relations
        })
      end

    end
  end
end

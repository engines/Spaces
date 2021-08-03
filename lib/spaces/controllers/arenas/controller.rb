module Arenas
  module Controllers
    class Controller < ::Spaces::Controllers::RESTController

      def space_identifier; :arenas ;end

      def method_class_map
        @method_class_map ||= super.merge {
          resolve: [::Arenas::Commands::Resolving, force: true]
        }
      end

    end
  end
end

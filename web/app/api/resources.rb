module App
  class Api < Base
    class Resources

      def initialize(api, name, parent)
        @api = api
        @name = name
        @parent = parent
      end

      attr_reader :api, :name, :parent

      def build
        api.get("#{parent_prefix}/#{name}", &index)
        # TODO: build other routes
        # api.post("#{parent_prefix}/#{name}", &new)
        # api.get("#{parent_prefix}/#{name}/:id", &show)
        # api.delete("#{parent_prefix}/#{name}/:id", &delete)
        # etc
      end

      def index
        Proc.new do
          Object.const_get(:projects.camelize)::Controller.new(params).index
          # space::Controller.new(params).index
        end
      end

      def parent_prefix
        parent ? parent.prefix : nil
      end

      def prefix
        "#{parent_prefix}/#{name}/:#{name}_id"
      end

      def resources(name)
        api.resources(name, self)
      end

      def klass
        name.camelize
      end

      def space
        parent ? parent.space.const_get( klass ) : Object.const_get(klass)
      end
      #
      # def controller
      #   @controller ||= space::Controller.new
      # end

    end
  end
end

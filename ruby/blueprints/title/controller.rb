require './ruby/spaces/controller'
# require './ruby/blueprints/blueprint'
# require './ruby/blueprints/installations/controller'

module Blueprints
  module Title
    class Controller < Spaces::Controller

      def update
        puts params
        o = space.by(descriptor_for({identifier: params[:id]}))
        o.title = params[:title] || ''
        space.save(o)
        o.title
      end

    end
  end
end

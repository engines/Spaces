require './ruby/spaces/controller'

module Blueprints
  module Description
    class Controller < Spaces::Controller

      def update
        puts params
        o = space.by(descriptor_for({identifier: params[:id]}))
        o.description = params[:description] || ''
        space.save(o)
        o.description
      end

    end
  end
end

require './src/spaces/controller'

module Blueprints
  module Memory
    class Controller < Spaces::Controller

      def update
        puts params
        o = space.by(descriptor_for({identifier: params[:id]}))
        o.memory = params[:memory] || ''
        space.save(o)
        o.memory
      end

    end
  end
end

module Blueprints::Installations
  class Controller < Spaces::Controller

    def index
      b = space.by(descriptor_for({identifier: params[:blueprint_id]}))
      universe.installations.descriptors.select do |d|
        d.repository == b.descriptor.repository
      end.map(&:identifier).sort
    end

    def create
      d = descriptor_for(params[:installation])
      universe.installations.save(
        Installations::Installation.new(
          blueprint: universe.blueprints.by(
            descriptor_for({identifier: params[:blueprint_id]})
          ),
          descriptor: d
        )
      )
      d.identifier
    end

  end
end

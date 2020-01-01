require_relative '../blueprint/blueprint'
require_relative '../universal/space'

module Blueprint
  class Space < ::Framework::Space
    # The dimensions in which blueprints exist

    def encloses?(blueprint)
      persistence.encloses(blueprint.descriptor)
    end

    def by(descriptor)
      open_struct_from_json(persistence.by(descriptor))
    end

    def import(descriptor)
      persistence.import(descriptor)
    end

    def persistence
      universal.persistence
    end
  end
end

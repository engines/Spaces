require_relative '../blueprint/blueprint'
require_relative '../universal/space'

module Blueprint
  class Space < ::Framework::Space
    # The dimensions in which blueprints exist

    def encloses?(blueprint)
      persistence.encloses(blueprint.descriptor)
    end

    def by(descriptor)
      model_class.new(open_struct_from_json(persistence.by(descriptor))).tap do |m|
        m.descriptor = descriptor
      end
    end

    def import(descriptor)
      persistence.import(descriptor)
    end

    def model_class
      Blueprint
    end

    def persistence
      universal.persistence
    end
  end
end

require_relative '../blueprint/blueprint'
require_relative '../universal/space'

module Blueprint
  class Space < ::Framework::Space
    # The dimensions in which blueprints exist

    def by(descriptor)
      universal.persistence.by(descriptor)
    end

    def encloses?(blueprint)
    end

    def import(descriptor)
      universal.persistence.import(descriptor)
    end
  end
end

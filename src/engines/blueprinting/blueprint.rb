module Blueprinting
  class Blueprint < Emissions::Emission

    delegate(blueprints: :universe)

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

  end
end

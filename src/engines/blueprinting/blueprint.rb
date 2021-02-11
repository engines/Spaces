module Blueprinting
  class Blueprint < Emissions::Emission

    delegate(blueprints: :universe)

    alias_method :blueprint, :itself

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

  end
end

require_relative 'status'

module Blueprinting
  class Blueprint < Emissions::Emission
    include Blueprinting::Status

    delegate([:blueprints, :publications] => :universe)

    alias_method :blueprint, :itself

    def descriptor; @descriptor ||= blueprints.by(identifier, Spaces::Descriptor) ;end

  end
end

module Divisions
  class Volume < ::Emissions::Subdivision
    include Emissions::Resolvable

    alias_method :identifier, :context_identifier

  end
end

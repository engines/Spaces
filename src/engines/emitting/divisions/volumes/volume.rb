module Divisions
  class Volume < ::Emissions::Subdivision
    include Emissions::DivisionResolvable

    alias_method :identifier, :context_identifier

  end
end

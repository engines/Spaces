module Divisions
  class Volume < ::Divisions::Subdivision

    alias_method :identifier, :context_identifier

  end
end

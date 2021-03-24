module Divisions
  class Volume < ::Divisions::Subdivision

    alias_method :identifier, :context_identifier

    def device_stanzas; ;end

  end
end

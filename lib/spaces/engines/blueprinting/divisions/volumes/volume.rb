module Divisions
  class Volume < ::Divisions::Subdivision

    class << self
      def features; [:source, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    def device_stanzas; ;end

  end
end

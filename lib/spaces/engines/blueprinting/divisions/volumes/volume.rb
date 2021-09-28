module Divisions
  class Volume < ::Divisions::Subdivision
    include RuntimeDefining

    class << self
      def features; [:source, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    delegate device_stanzas: :provider_aspect

  end
end

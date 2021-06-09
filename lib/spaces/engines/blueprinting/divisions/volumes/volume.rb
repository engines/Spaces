module Divisions
  class Volume < ::Divisions::Subdivision
    include ProviderDependent

    class << self
      def features; [:source, :destination] ;end
    end

    alias_method :identifier, :context_identifier

    delegate device_stanzas: :provider_aspect

    def provider_aspect_name_elements
      ['providers', runtime_identifier, qualifier]
    end

  end
end

module Divisions
  class Provider < ::Divisions::Division
    include ProviderDependent

    class << self
      def features; [:type] ;end
    end

    delegate required_stanza: :provider_aspect

    def type
      struct.type || derived_features[:type]
    end

    def provider_artifacts
      provider_aspect.provider_stanzas
    end

    def provider_aspect_name_elements
      ['providers', struct.type]
    end

    protected

    def derived_features
      @derived_features ||= {
        type: context_identifier
      }
    end
  end
end

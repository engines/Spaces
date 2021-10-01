module Divisions
  class Provider < ::Divisions::Division

    class << self
      def features; [:type] ;end
    end

    delegate required_stanza: :provider_division_aspect

    def type
      struct.type || derived_features[:type]
    end

    def aspect_name_elements
      [super, [struct.type] * 2].flatten
    end

    protected

    def derived_features
      @derived_features ||= {
        type: context_identifier
      }
    end
  end
end

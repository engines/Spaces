module Divisions
  class Provider < ::Divisions::Division

    class << self
      def features; [:type] ;end

      def prototype(emission:, label:)
        constant_for(type_for(emission)).new(emission: emission, label: label)
      end

      def type_for(emission)
        struct_for(emission).type || context_identifier
      end

      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}")
      end

      def struct_for(emission)
        emission.struct.provider
      end
    end

    def type; struct.type || derived_features[:type] ;end

    def provider_artifacts; provider_stanzas ;end

    protected

    def derived_features
      @derived_features ||= {
        type: context_identifier
      }
    end
  end
end

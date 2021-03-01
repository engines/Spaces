module Divisions
  class Provider < ::Divisions::Division

    class << self
      def prototype(emission:, label:)
        constant_for(struct_for(emission).type).new(emission: emission, label: label)
      end

      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}")
      end

      def struct_for(emission)
        emission.struct.provider
      end
    end

    delegate(arena: :emission)

    def type
      struct.type || context_identifier
    end

  end
end

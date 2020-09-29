module Associations
  class Dns < ::Emissions::Division

    class << self
      def prototype(emission:, label:)
        constant_for(struct: struct_for(emission)).new(emission: emission, label: label)
      end

      def constant_for(struct:)
        Module.const_get("/providers/#{struct.type}".camelize)
      end

      def struct_for(emission)
        emission.struct.dns || default_struct
      end

      def default_struct
        OpenStruct.new(type: :power_dns)
      end
    end

    delegate(identifier: :emission)

  end
end

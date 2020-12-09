module Associations
  class Dns < ::Emissions::Division

    class << self
      def prototype(emission:, label:)
        constant_for(struct_for(emission).type).new(emission: emission, label: label)
      end

      def constant_for(type)
        Module.const_get("/providers/#{type}".camelize)
      end

      def struct_for(emission)
        emission.struct.dns || default_struct
      end

      def default_struct
        OpenStruct.new(type: :power_dns)
      end
    end

    alias_method :arena, :emission

    delegate(identifier: :arena)

  end
end

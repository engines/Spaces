module Divisions
  class ModuleList < ::Divisions::Subdivision

    class << self
      def prototype(type:, struct:, division:)
        constant_for(type || struct.type).new(struct: struct, division: division)
      end

      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}")
      end
    end

    def identifier; qualifier ;end

  end
end

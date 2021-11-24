module Divisions
  class ModuleList < ::Divisions::Subdivision

    class << self
      def prototype(type:, struct:, division:)
        class_for(type || struct.type).new(struct: struct, division: division)
      end

      def class_for(type)
        super(:providers, type.to_s.camelize)
      end
    end

    def identifier; qualifier ;end

  end
end

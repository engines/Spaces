module Divisions
  class ManagedPackageList < ::Divisions::Subdivision

    class << self
      def prototype(type:, struct:, division:) =
        class_for(type || struct.type).new(struct: struct, division: division)

      def class_for(type) = super(:providers, type.to_s.camelize)
    end

    def identifier = qualifier

  end
end

require_relative 'division'

module Emissions
  class Subdivision < Division

    class << self
      def prototype(type: nil, struct:, division:)
        constant_for(type || struct.type).new(struct: struct, division: division)
      end

      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}")
      end
    end

    relation_accessor :division

    delegate([:emission, :context_identifier] => :division)

    def initialize(struct:, division:)
      self.struct = struct
      self.division = division
    end

  end
end

require_relative 'division'

module Emissions
  class Subdivision < Division

    class << self
      def prototype(struct:, division:)
        constant_for(struct: struct).new(struct: struct, division: division)
      end

      def constant_for(struct:)
        Module.const_get("/providers/#{struct.type}".camelize)
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

require_relative 'division'

module Emissions
  class Subdivision < Division

    class << self
      def prototype(type: nil, struct:, division:)
        constant_for(type || struct.type).new(struct: struct, division: division)
      end

      def constant_for(type)
        Module.const_get("::Providers::#{type.camelize}")
      end
    end

    relation_accessor :division

    delegate([:emission, :context_identifier] => :division)

    def inflated
      duplicate(self).tap { |s| s.struct = s.struct.merge(inflatables) }
    end

    def empty; self.class.new(division: division) ;end

    def initialize(division:, struct: nil)
      self.division = division
      self.struct = struct
    end

  end
end

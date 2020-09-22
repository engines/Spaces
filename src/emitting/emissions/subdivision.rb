require_relative 'division'

module Emissions
  class Subdivision < Division

    relation_accessor :division

    delegate([:emission, :context_identifier] => :division)

    def initialize(struct:, division:)
      self.struct = struct
      self.division = division
    end

  end
end

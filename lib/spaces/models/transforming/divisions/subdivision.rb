require_relative 'division'

module Divisions
  class Subdivision < Division

    relation_accessor :division

    delegate([:emission, :context_identifier] => :division)

    def empty = self.class.new(division: division)

    def initialize(division:, struct: nil)
      self.division = division
      self.struct = struct || OpenStruct.new
    end

  end
end

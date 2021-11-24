require_relative 'binding'

module Divisions
  class BindingInArena < Binding

    relation_accessor :arena

    def initialize(binding, arena)
      super(division: binding.division, struct: binding.struct)
      self.arena = arena
    end

  end
end

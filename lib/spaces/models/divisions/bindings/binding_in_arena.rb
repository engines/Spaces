require_relative 'binding'

module Divisions
  class BindingInArena < Binding

    relation_accessor :arena

    def initialize(binding, arena)
      super(division: binding.division, struct: binding.struct)
      self.arena = arena
    end

    def resolution
      @resolution ||= super || blueprint&.resolution_in(arena)
    end

  end
end

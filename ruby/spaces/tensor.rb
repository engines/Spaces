# TODO: decide where this should go

require_relative 'model'

module Spaces
  class Tensor < Model

    relation_accessor :blueprint

    def struct
      @struct ||= blueprint.struct
    end

    def initialize(blueprint)
      self.blueprint = blueprint
    end

  end
end

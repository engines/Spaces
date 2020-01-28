require_relative 'model'

module Spaces
  class Tensor < Model

    relation_accessor :blueprint,
      :precursor,
      :product

  end
end

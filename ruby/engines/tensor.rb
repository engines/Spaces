require_relative 'model'

module Engines
  class Tensor < Model
    # A sufficient set of values that guarantee a tranformation into a corresponding model object

    relation_accessor :blueprint,
      :precursor,
      :product

  end
end

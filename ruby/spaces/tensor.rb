require_relative 'product'

module Spaces
  class Tensor < Product
    # A sufficient set of values that guarantee a tranformation into a corresponding model object

    relation_accessor :blueprint,
      :precursor,
      :product

  end
end

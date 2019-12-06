require_relative '../engines/tensor'
require_relative '../blueprint/blueprint'
require_relative 'container'

module Container
  class Tensor < Engines::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable container

    relation_accessor :blueprint,
      :container

  end
end

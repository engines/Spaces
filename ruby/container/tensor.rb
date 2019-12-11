require_relative '../framework/tensor'
require_relative '../blueprint/blueprint'
require_relative 'container'

module Container
  class Tensor < ::Framework::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable container

    relation_accessor :blueprint,
      :container

  end
end

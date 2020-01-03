require_relative '../spaces/tensor'
require_relative '../blueprint/blueprint'
require_relative 'container'

module Container
  class Tensor < ::Spaces::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable container

    relation_accessor :blueprint,
      :container

  end
end

require_relative '../spaces/tensor'
require_relative '../blueprint/blueprint'
require_relative 'executable'

module Executable
  class Tensor < ::Spaces::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable excutable

    alias_accessor(:executable, :product)

  end
end

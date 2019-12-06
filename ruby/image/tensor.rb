require_relative '../engines/tensor'
require_relative '../software/installation'
require_relative '../blueprint/blueprint'
require_relative 'image'

module Image
  class Tensor < Engines::Tensor
    # A sufficient set of values that guarantee a tranformation into a realiably predictable software image
      
    alias_accessor(:installation, :precursor)
    alias_accessor(:image, :product)

  end
end

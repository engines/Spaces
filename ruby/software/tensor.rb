require_relative '../spaces/tensor'
require_relative 'version'
require_relative '../blueprint/blueprint'

module Software
  class Tensor < ::Spaces::Tensor
    # A sufficient set of values that guarantee a copy of a software version resides in persistence_space

    alias_accessor(:software_version, :precursor)
    alias_accessor(:installation, :product)

  end
end

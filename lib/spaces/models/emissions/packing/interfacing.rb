module Packing
  module Interfacing
    include Emissions::Providing
    
    def build(pack)
      interface_for(pack).build
    end

  end
end

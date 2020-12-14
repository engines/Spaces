module Divisions
  class OtherPackages < ::Emissions::Divisible
    include ::Packing::Division

    def packing_stanza_for(key)
      all.map(&:packing_stanza) if key == :adds
    end

    def keys; [:adds] ;end

  end
end

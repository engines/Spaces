module Divisions
  class OtherPackages < ::Divisions::Divisible

    alias_method :divisible_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); divisible_embedded_with(other) ;end

    def packing_stanza_for(key)
      all.map(&:packing_stanza) if key == :adds
    end

    def keys; [:adds] ;end

  end
end

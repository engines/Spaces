module Divisions
  class OtherPackages < ::Divisions::Divisible
    include DivisibleAspects

    alias_method :divisible_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); divisible_embedded_with(other) ;end

    def keys; [:adds] ;end

  end
end

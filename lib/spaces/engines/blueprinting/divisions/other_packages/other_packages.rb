module Divisions
  class OtherPackages < ::Divisions::Divisible
    include DivisibleAspects
    include ::Packing::Divisible

    def keys; [:adds] ;end

  end
end

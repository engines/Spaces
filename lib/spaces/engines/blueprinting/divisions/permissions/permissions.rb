module Divisions
  class Permissions < ::Divisions::Divisible
    include DivisibleAspects
    include ::Packing::Divisible

    def keys; [:late] ;end

  end
end

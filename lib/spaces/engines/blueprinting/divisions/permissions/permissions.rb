module Divisions
  class Permissions < ::Divisions::Divisible
    include DivisibleAspects

    alias_method :divisible_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); divisible_embedded_with(other) ;end

    def keys; [:late] ;end

  end
end

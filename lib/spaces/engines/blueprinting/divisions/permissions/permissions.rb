module Divisions
  class Permissions < ::Divisions::Divisible

    alias_method :divisible_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); divisible_embedded_with(other) ;end

    def packing_payload_for(key)
      all.map(&:packing_payload) if key == :late
    end

    def keys; [:late] ;end

  end
end

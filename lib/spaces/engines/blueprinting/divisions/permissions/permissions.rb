module Divisions
  class Permissions < ::Divisions::Divisible

    alias_method :divisible_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); divisible_embedded_with(other) ;end

    def packing_artifact_for(key)
      all_provider_aspects.map(&:packing_artifact) if key == :late
    end

    def keys; [:late] ;end

  end
end

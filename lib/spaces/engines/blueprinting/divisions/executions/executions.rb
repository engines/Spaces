module Divisions
  class Executions < ::Divisions::Divisible
    include DivisibleAspects

    alias_method :divisible_embedded_with, :embedded_with

    include ::Packing::Division

    def embedded_with(other); divisible_embedded_with(other) ;end

    def transformed_to(transformation)
      if runtime_identifier
        super.select { |s| s.type == runtime_identifier }
      else
        super
      end
    end

    def keys; [:first] ;end

  end
end

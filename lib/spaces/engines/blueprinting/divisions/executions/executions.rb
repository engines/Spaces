module Divisions
  class Executions < ::Divisions::Divisible
    include DivisibleAspects
    include ::Packing::Divisible

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

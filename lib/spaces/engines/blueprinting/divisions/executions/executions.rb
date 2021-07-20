module Divisions
  class Executions < ::Divisions::Divisible
    include DivisibleAspects
    include ::Packing::Divisible

    def transformed_to(transformation)
      in_blueprint? ? super : super.select { |s| s.type == runtime_identifier }
    end

    def keys; [:first] ;end

  end
end

module Divisions
  class Executions < ::Divisions::Divisible
    # TODO: these dependencies feel wrong
    include DivisibleAspects
    include ::Packing::Divisible

    def transformed_to(transformation)
      in_blueprint? ? super : super.select { |s| s.type == runtime_qualifier }
    end

    def keys; [:first] ;end

  end
end

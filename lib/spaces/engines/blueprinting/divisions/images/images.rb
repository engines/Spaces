module Divisions
  class Images < ::Divisions::Divisible

    def transformed_to(transformation)
      if should_limit_for_runtime?
        super.select { |s| s.type == runtime_identifier }
      else
        super
      end
    end

    def should_limit_for_runtime?
      runtime_identifier
    end

  end
end

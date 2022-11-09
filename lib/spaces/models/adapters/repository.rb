module Adapters
  class Repository < Division

    class << self
      def prototype(division) =
        class_for(division.type).new(division)

      def class_for(type) = super(:adapters, type.to_s.camelize, qualifier)
    end

  end
end

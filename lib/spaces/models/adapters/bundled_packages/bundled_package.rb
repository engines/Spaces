module Adapters
  class BundledPackage < Division

    class << self
      def dynamic_type(division) =
        class_for(division.protocol).new(division)

      def class_for(type) = super(:adapters, type.to_s.camelize, qualifier)
    end

  end
end

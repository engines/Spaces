module Adapters
  class BundledPackage < Division

    class << self
      def extractor_class_for(format) = class_for(:package_extractors, format.to_s.camelize)
    end

    delegate(
      extractor_class_for: :klass,
      command: :extractor
    )

    def extractor
      @extractor ||= extractor_class_for(format).new(self)
    end

    def format = division.format

  end
end

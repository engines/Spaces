module Adapters
  class BundledPackage < Division

    delegate(
      command: :extractor
    )

    def extractor
      @extractor ||= default_extractor_class.class_for(format).new(self)
    end

    def default_extractor_class = ::Packaging::Extractor

    def format = division.format

  end
end

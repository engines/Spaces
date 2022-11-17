module PackageExtractors
  class Extractor < ::Packaging::Accessor

    class << self
      def class_for(name)
        super(:package_extractors, name.to_s.camelize)
      rescue NameError => e
        klass
      end
    end

    def dynamic_type =
      klass.class_for(format).new(state)

  end
end

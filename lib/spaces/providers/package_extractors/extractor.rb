module PackageExtractors
  class Extractor < ::Spaces::Thing

    class << self
      def class_for(format) = super(:extractors, format.to_s.camelize)
    end

    relation_accessor :adapter

    def dynamic_type =
      klass.class_for(format).new(adapter)

    def initialize(adapter)
      self.adapter = adapter
    end

  end
end

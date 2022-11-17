require_relative 'accessor'

module Packaging
  class Extractor < Accessor

    class << self
      def class_for(name)
        super
      rescue NameError => e
        klass
      end
    end

    def dynamic_type =
      klass.class_for(format).new(state)

  end
end

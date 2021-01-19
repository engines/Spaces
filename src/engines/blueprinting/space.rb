module Blueprinting
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

  end
end

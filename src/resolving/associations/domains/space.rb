module Domains
  class Space < ::Spaces::Space
    include Defaultables::Space

    class << self
      def default_model_class
        Domain
      end
    end

  end
end

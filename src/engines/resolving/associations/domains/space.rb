module Associations
  class Domains
    class Space < ::Spaces::Space

      class << self
        def default_model_class
          Domain
        end
      end

    end
  end
end

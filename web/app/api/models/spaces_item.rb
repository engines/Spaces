module App
  class Api
    module Models
      class SpacesItem

        def initialize(identifier)
          @identifier = identifier
        end

        attr_accessor :identifier

        def to_json
          to_h.to_json
        end

        def descriptor
          ::Spaces::Descriptor.new(identifier: identifier)
        end

        def universe
          Spaces.universe
        end

      end
    end
  end
end

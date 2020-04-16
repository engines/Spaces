module App
  class Api
    module Models
      class SpacesCollection

        def to_json
          to_a.to_json
        end

        def universe
          Spaces.universe
        end

      end
    end
  end
end

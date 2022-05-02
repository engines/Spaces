module Arenas
  module Commands
    class BuildingFrom < Saving

      def model
        @model ||=
          current_model.build_from(identifier: input_for(:image_identifier))
      end

    end
  end
end

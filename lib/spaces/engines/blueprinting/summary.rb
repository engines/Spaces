module Blueprinting
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        about: struct.about,
        location: flat_location_struct,
        publication: {
          exist: publications.exist?(identifier)
        },
        utilized: all_arenas.any?
      )
    end

    def flat_location_struct
      @flat_location_struct ||=
        OpenStruct.new(exist: locations.exist?(identifier)).merge(locations.exist_then_by(identifier)&.struct)
    end

  end
end

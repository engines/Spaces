module Blueprinting
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        about: struct.about,
        location: {
          exist: locations.exist?(identifier),
          descriptor: location_struct,
        },
        publication: {
          exist: publications.exist?(identifier)
        },
        utilized: all_arenas.any?
      )
    end

    def location_struct
      @location_struct ||= locations.exist_then_by(identifier)&.struct
    end

  end
end

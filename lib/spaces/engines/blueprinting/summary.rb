module Blueprinting
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        about: struct.about,
        location: location&.struct,
        publication: {
          exist: publications.exist?(identifier)
        },
        utilized: all_arenas.any?
      ).compact
    end

    def location
      @location ||= locations.by(identifier) if locations.exist?(identifier)
    end

  end
end

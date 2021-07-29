module Blueprinting
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        about: about.struct,
        location: location&.struct,
        publication: {
          exist: publications.exist?(identifier)
        },
        utilized: all_arenas.any?
      )
    end

    def location
      @location ||= locations.by(identifier)
    end

  end
end

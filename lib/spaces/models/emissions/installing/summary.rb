module Installing
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        resolution: {
          exist: resolutions.exist?(identifier)
        }
      )
    end

  end
end

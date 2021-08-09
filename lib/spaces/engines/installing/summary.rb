module Installing
  module Summary

    def summary
      OpenStruct.new(
        resolution: {
          exist: resolutions.exist?(identifier)
        }
      )
    end

  end
end

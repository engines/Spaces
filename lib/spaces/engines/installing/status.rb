module Installing
  module Status

    def status
      OpenStruct.new(
        resolution: {
          exist: resolutions.exist?(identifier)
        }
      )
    end

  end
end

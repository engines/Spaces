module Installing
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        stale: stale?,
        resolution: {
          exist: resolutions.exist?(identifier)
        }
      )
    end

    def stale?
      arena.state.stale_installations.include?(identifier)
    end

  end
end

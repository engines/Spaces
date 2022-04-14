module Resolving
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        stale: stale?,
        pack: {
          exist: packs.exist?(identifier),
          allowed: packable?
        },
        orchestration: {
          exist: orchestrations.exist?(identifier)
        }
      )
    end

    def stale?
      arena.state.stale_resolutions.include?(identifier)
    end

  end
end

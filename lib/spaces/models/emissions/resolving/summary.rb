module Resolving
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        stale: stale?,
        installation: {
          confirmed: installations.exist?(identifier)
        },
        pack: {
          exist: packs.exist?(identifier),
          allowed: packable?
        },
        provisions: {
          exist: provisioning.exist?(identifier)
        }
      )
    end

    def stale?
      arena.state.stale_resolutions.include?(identifier)
    end

  end
end

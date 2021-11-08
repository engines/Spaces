module Resolving
  module Summary

    def summary
      OpenStruct.new(
        installation: {
          exist: installations.exist?(identifier)
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

  end
end

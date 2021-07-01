module Resolving
  module Status

    def status
      OpenStruct.new(
        installation: {
          exist: installations.exist?(identifier)
        },
        pack: {
          exist: packs.exist?(identifier),
          allowed: packable?
        },
        provisions: {
          exist: provisioning.exist?(identifier),
          allowed: provisionable?
        }
      )
    end

  end
end

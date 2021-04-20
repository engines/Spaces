module Resolving
  module Status

    def status
      OpenStruct.new(
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

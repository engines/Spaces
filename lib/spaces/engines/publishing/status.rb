module Publishing
  module Status

    def status
      OpenStruct.new(
        descriptor: descriptor.struct,
        blueprint: {
          exist: blueprints.exist?(identifier)
        },
        plan: {
          exist: plans.exist?(identifier)
        }
      )
    end

  end
end

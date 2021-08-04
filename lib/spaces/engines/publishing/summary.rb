module Publishing
  module Summary

    def summary
      OpenStruct.new(
        descriptor: descriptor.struct,
        blueprint: {
          exist: blueprints.exist?(identifier)
        }
      )
    end

  end
end

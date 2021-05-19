module Publishing
  class Blueprint < Emissions::Emission

    delegate([:blueprints, :publications] => :universe)

    def repository
      @respository ||= publications.respository_for(descriptor)
    end

    def descriptor
      @descriptor ||= descriptor_class.new(identifier: identifier)
    end

    def status
      OpenStruct.new(
        descriptor: descriptor.struct,
        blueprint: {
          exist: blueprints.exist?(identifier),
        }
      )
    end

    def transformed_for_publication; localized ;end
  end
end

module Planning
  module Status

    def status
      OpenStruct.new(
        publication: {
          exist: publications.exist?(identifier)
        },
        blueprint: {
          exist: blueprints.exist?(identifier)
        }
      )
    end

  end
end

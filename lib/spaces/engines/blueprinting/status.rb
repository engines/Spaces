module Blueprinting
  module Status

    def status
      OpenStruct.new(
        publication: {
          exist: publications.exist?(identifier),
        }
      )
    end

  end
end

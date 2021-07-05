require_relative 'publishing'
require_relative 'status'

module Publishing
  class Blueprint < Emissions::Emission
    include ::Publishing::Publishing
    include ::Publishing::Status

    delegate([:blueprints, :publications] => :universe)

    def repository
      @respository ||= publications.respository_for(descriptor)
    end

    def descriptor
      @descriptor ||= descriptor_class.new(identifier: identifier)
    end

    def transformed_for_publication; localized ;end

  end
end

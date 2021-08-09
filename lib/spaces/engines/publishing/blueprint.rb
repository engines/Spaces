require_relative 'publishing'
require_relative 'summary'

module Publishing
  class Blueprint < Emissions::Emission
    include ::Publishing::Publishing
    include ::Publishing::Summary

    delegate([:blueprints, :publications] => :universe)

    def repository
      @repository ||= publications.repository_for(descriptor)
    end

    def descriptor
      @descriptor ||= descriptor_class.new(identifier: identifier)
    end

    def transformed_for_publication; localized ;end

    def in_blueprint?; true ;end
    
  end
end

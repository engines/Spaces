require_relative 'publishing'
require_relative 'summary'

module Publishing
  class Blueprint < Emissions::Emission
    include ::Publishing::Publishing
    include ::Publishing::Summary

    class << self
      def composition_class = Composition
    end

    delegate([:blueprints, :publications] => :universe)

    def blueprint_identifier = identifier
    def application_identifier = identifier

    def repository
      @repository ||= publications.repository_for(descriptor)
    end

    def descriptor
      @descriptor ||= descriptor_class.new(identifier: identifier)
    end

    def transformed_for_publication = localized

    def in_blueprint? = true

  end
end

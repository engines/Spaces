module Commissioning
  class Service < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    def services
      container_file_names.map do |p|
        OpenStruct.new(
          container_identifier: identifier,
          name: milestone_identifier_for(p),
          path: p
        )
      end
    end

    def container_file_names
      resolutions.container_file_names_for(:servicing, identifier)
    end

    def milestone_identifier_for(path)
      path.basename.to_s.split('_').first
    end

  end
end

module Commissioning
  class Service < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    relation_accessor :consumer

    delegate(runtime_provider: :arena)

    alias_method :provider, :runtime_provider

    def execute_for(milestone_name)
      provider.interface_for(self, purpose: :service).execute_all_for(milestone_name)
    end

    def milestones_for(name)
      milestones.select { |m| m.name == name.to_s }
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

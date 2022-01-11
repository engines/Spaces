module Commissioning
  class Service < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    relation_accessor :consumer

    delegate(runtime_provider: :arena)

    alias_method :provider, :runtime_provider

    def execute_for(milestone_name)
      interface.execute_commands_for(milestone_name)
    end

    def interface
      @interface ||= provider.interface_for(self, purpose: :service)
    end

    def commands_for(name)
      milestones_for(name).map do |m|
        ["#{m.path}", parameters].flatten
      end
    end

    def milestones_for(name)
      milestones.select { |m| m.name == name.to_s }
    end

    def parameters
      consumer.send(blueprint_identifier).configuration_string_array
    end

    def services
      container_file_names.map do |p|
        OpenStruct.new(
          service_identifier: identifier,
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

module Commissioning
  class Service < ::Resolving::Emission
    include ::Transforming::Precedence

    class << self
      def composition_class; Composition ;end
    end

    relation_accessor :consumer

    delegate(registry: :universe)

    def execute_for(milestone_name)
      unless registered?(milestone_name)
        interface.execute_commands_for(milestone_name)
        register(milestone_name)
      end
    end

    def registered?(milestone_name) =
      registry.has_milestone?(service_entry_identifier, milestone_name)

    def register(milestone_name) =
      registry.save_milestone(service_entry_identifier, milestone_name)

    def interface
      @interface ||= provider.interface_for(self)
    end

    def commands_for(name) =
      milestones_for(name).map { |m| "#{m.path}" }

    def milestones_for(name)
      milestones.
        select { |m| m.name == name.to_s }.
        sort_by { |m| precedence.index(precedence_for(m.precedence)) }
    end

    def parameters =
      consumer.send(blueprint_identifier).service_string_array

    def services
      precedence_file_names.map do |p|
        OpenStruct.new(
          service_identifier: identifier,
          name: milestone_identifier_from(p),
          precedence: precedence_from(p),
          path: container_path_from(p)
        )
      end
    end

    def container_path_from(precedence_path) =
      "/#{precedence_path}".split('/').drop(1).join('/')

    def precedence_from(precedence_path) =
      "#{precedence_path}".split('/').first

    def precedence_file_names =
      resolutions.precedence_file_names_for(:servicing, identifier)

    def milestone_identifier_from(path) =
      path.basename.to_s.split('_').first

    def cache_identifiers!
      struct.consumer_identifier = consumer.identifier
      struct.service_entry_identifier = [resolution.identifier, consumer.identifier].join(identifier_separator)
    end

  end
end

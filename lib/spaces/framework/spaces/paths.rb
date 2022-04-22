require_relative 'workspace'

module Spaces
  module Paths
    include Workspace

    def path
      workspace.join("#{universes.identifier}", "#{identifier}")
    end

    def reading_path_for(identifiable, klass = default_model_class)
      path.join(identifiable.identifier.as_path, klass.qualifier)
    end

    def writing_path_for(identifiable)
      path.join(*([identifiable.context_identifier.as_path, identifiable.subpath].compact))
    end

    def streaming_path_for(identifiable)
      workspace.join("#{universes.identifier}", "#{default_streaming_location}", "#{identifiable.identifier.as_path}")
    end

    def default_streaming_location; :streams ;end

    def path_for(identifiable)
      path.join(identifiable.context_identifier.as_path)
    end

    def precedence_file_names_for(phase, identifier)
      file_names_for(phase, identifier).map do |p|
        Pathname.new("#{p.to_s.split("#{phase}/").last}")
      end
    end

    def file_names_for(directory, identifier)
      file_path_for(directory, identifier).glob('**/*').reject(&:directory?)
    end

    def file_path_for(symbol, context_identifier)
      path.join("#{context_identifier.as_path}", "#{symbol}")
    end

    def container_path_for(identifiable)
      Pathname("/#{identifier}").join(identifiable.context_identifier.as_path)
    end

  end
end

module Packing
  class Space < ::Spaces::Space

    class << self
      def default_model_class; Pack ;end
    end

    delegate(resolutions: :universe)

    def identifiers(arena_identifier: '*', blueprint_identifier: '*')
      path.glob("#{arena_identifier}/#{blueprint_identifier}").map do |p|
        "#{p.relative_path_from(path)}"
      end
    end

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

    def save(model)
      raise PackWithoutImagesError, "Model doesn't have images: #{model.identifier}" unless model.has?(:builders)

      ensure_connections_exist_for(model)
      super.tap do
        path_for(model).join("#{artifact_name}.json").write(model.artifact.to_json)
      end
    rescue PackWithoutImagesError => e
      warn(error: e, identifier: model.identifier, klass: klass)
    end

    def artifact_name; 'template' ;end

    protected

    def ensure_connections_exist_for(model)
      model.connections_down.map(&:packed).each { |p| save(p) }
    end

  end

  class PackWithoutImagesError < StandardError
  end
end

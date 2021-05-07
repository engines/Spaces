require_relative 'packing'

module Packing
  class Space < ::Spaces::Space
    include ::Packing::Packing

    class << self
      def default_model_class; Pack ;end
    end

    delegate(resolutions: :universe)

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

    def save(model)
      raise ::Packing::Errors::NoImage, {identifier: model.identifier} unless model.has?(:builders)

      ensure_connections_exist_for(model)
      super.tap do
        path_for(model).join("commit.json").write(model.artifact.to_json)
      end
    rescue ::Packing::Errors::NoImage => e
      warn(error: e, identifier: model.identifier, klass: klass)
    end

    protected

    def ensure_connections_exist_for(model)
      model.connections_down.map(&:packed).each { |p| save(p) }
    end

  end
  
  module Errors
    class NoImage < ::Spaces::Errors::SpacesError
    end
  end
end

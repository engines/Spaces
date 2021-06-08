module Packing
  class Space < ::Spaces::Space
    include ::Emissions::ProviderDependent

    class << self
      def default_model_class; Pack ;end
    end

    delegate(resolutions: :universe)

    def commit(pack)
      provider_aspect_for(pack, self).commit
    end

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

    def save(pack)
      raise ::Packing::Errors::NoImage, {identifier: pack.identifier} unless pack.has?(:builders)

      ensure_connections_exist_for(pack)
      super.tap do
        provider_aspect_for(pack, self).save
      end
    rescue ::Packing::Errors::NoImage => e
      warn(error: e, identifier: pack.identifier, klass: klass)
    end

    protected

    def ensure_connections_exist_for(pack)
      pack.connections_down.map(&:packed).each { |p| save(p) }
    end

  end

  module Errors
    class NoImage < ::Spaces::Errors::SpacesError
    end
  end
end

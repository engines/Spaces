module Packing
  class Space < ::Settling::Space
    include Emissions::Providing

    class << self
      def default_model_class; Pack ;end
    end

    delegate(resolutions: :universe)

    def by(identifier, klass = default_model_class)
      super.tap do |m|
        m.resolution = resolutions.by(identifier)
      end
    end

    def save(pack)
      raise ::Packing::Errors::NoImage, {identifier: pack.identifier} unless pack.has?(:builders)

      ensure_connections_exist_for(pack)
      super.tap do
        translator_for(pack)&.save_artifacts_to(writing_path_for(pack))
      end
    rescue ::Packing::Errors::NoImage => e
      warn(error: e, identifier: pack.identifier, klass: klass)
    end

    def provider_role = :packing

    def copy_auxiliaries_for(pack)
      pack.auxiliary_directories.each do |d|
        copy_auxiliaries(pack, d)
      end
    end

    def remove_auxiliaries_for(pack)
      pack.auxiliary_directories.each do |d|
        remove_auxiliaries(pack, d)
      end
    end

    protected

    def ensure_connections_exist_for(pack)
      pack.connections_down.map(&:packed).each { |p| save(p) }
    end

    def copy_auxiliaries(pack, segment)
      "#{segment}".tap do |s|
        resolutions.path_for(pack).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(pack)) if p.exist?
        end
      end
    end

    def remove_auxiliaries(pack, segment)
      "#{segment}".tap do |s|
        path_for(pack).join(s).tap do |p|
          p.rmtree if p.exist?
        end
      end
    end

  end

  module Errors
    class NoImage < ::Spaces::Errors::SpacesError
    end
  end
end

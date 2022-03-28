require_relative 'synchronizing'

module Publishing
  class Space < Spaces::Git::Space
    include ::Spaces::Streaming
    include Synchronizing

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate([:locations, :blueprints] => :universe)

    alias_method :by, :by_json
    alias_method :save, :save_json
    alias_method :imported?, :exist?

    def default_extension; :json ;end

    def modified_at(*args)
      super(*args, as: default_extension)
    end

    def import(descriptor, args)
      with_streaming(descriptor, :import) do
        stream_for(descriptor, :import).output("\n")
        by_import(descriptor, args)
      end
    end

    def by_import(descriptor, force: false)
      super.tap do |m|
        locations.ensure_located(m)
        blueprints.by_import(descriptor, force: force)
        m.bindings.each do |b|
          by_import(b.descriptor) if (!imported?(b.descriptor) || force)
        end
      end
    rescue ::Spaces::Errors::ImportFailure => e
      locations.exist_then_delete(descriptor)
      logger.info(e)
    rescue ::Spaces::Errors::ReimportFailure => e
      logger.info(e)
    end

    def export(**args)
      args[:identifier].tap do |i|
        with_streaming(i, :export) do
          stream_for(i, :export).output("\n")
          synchronize_with(blueprints, i)
          super(locations.by(i), **args)
        rescue ::Spaces::Errors::ExportFailure => e
          logger.info(e)
        end
      end
    end

  end
end

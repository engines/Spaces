require_relative 'synchronizing'

module Publishing
  class Space < Spaces::Git::Space
    include ::Streaming::Streaming
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
      by_import(descriptor, args)
    end

    def by_import(descriptor, force: false)
      sa = streaming_args_for(descriptor, :import)
      importable = []
      with_streaming(sa) do
        super.tap do |m|
          locations.ensure_located(m)
          blueprints.by_import(descriptor, force: force)
          m.bindings.each do |b|
            importable.push(b.descriptor) if (!imported?(b.descriptor) || force)
          end
        end
      end
      importable.each do |descriptor|
        by_import(descriptor)
      end
    rescue ::Spaces::Errors::ImportFailure => e
      locations.exist_then_delete(descriptor)
      logger.info(e)
    rescue ::Spaces::Errors::ReimportFailure => e
      logger.info(e)
    end

    def export(**args)
      args[:identifier].tap do |i|
        sa = streaming_args_for(i, :import)
        with_streaming(sa) do
          stream_for(sa).output("\n")
          synchronize_with(blueprints, i)
          super(locations.by(i), **args)
        rescue ::Spaces::Errors::ExportFailure => e
          logger.info(e)
        end
      end
    end

    def streaming_args_for(*elements)
      [identifier, elements].flatten
    end

  end
end

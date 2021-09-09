require_relative 'synchronizing'

module Publishing
  class Space < Spaces::Git::Space
    include ::Publishing::Synchronizing
    include Spaces::Filing

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate([:locations, :blueprints] => :universe)

    alias_method :identifiers, :simple_identifiers
    alias_method :by, :by_json
    alias_method :save, :save_json
    alias_method :imported?, :exist?

    def default_extension; :json ;end

    def modified_at(*args)
      super(*args, as: default_extension)
    end

    # TODO: The :thread option should default to false and be set by controller.
    def import(descriptor, force:, thread: false)
      identifier.tap do
        thread ?
        Thread.new { import_with_output(descriptor, force: force, rescue_exceptions: true) } :
        import_with_output(descriptor, force: force)
      end
    end

    def import_with_output(descriptor, force:, rescue_exceptions: false)
      output_to_file(import_out_path,
        content_lambda: ->(out) { import_git_repo(descriptor, force: force) { |output| out.call(output) } },
        rescue_exceptions: rescue_exceptions
      )
    end

    def import_git_repo(descriptor, force: false)
      logger.info("Git import...")
      begin
        by_import(descriptor, force: force) do |output|
          logger.info("> #{output.strip}")
          yield "#{{output: output}.to_json}\n"
        end
      rescue git_error => e
        yield "#{{output: "\n"}.to_json}\n"
        yield "#{{error: "Failed to import from #{descriptor.repository} (#{descriptor.branch})"}.to_json}\n"
      end
    end


    def by_import(descriptor, force:, &block)
      super.tap do |m|
        locations.ensure_located(m)
        blueprints.by_import(descriptor, force: force, &block)
        m.bindings.each do |b|
          by_import(b.descriptor, force: force, &block) if (!imported?(b.descriptor) || force)
        end
      end
    rescue ::Spaces::Errors::RepositoryFail => e
      locations.exist_then_delete(descriptor)
      raise e
    end

    def export(**args)
      args[:identifier].tap do |i|
        synchronize_with(blueprints, i)
        super(locations.by(i), **args)
      end
    end

    def import_out_path
      path.join("import.out")
    end

  end
end

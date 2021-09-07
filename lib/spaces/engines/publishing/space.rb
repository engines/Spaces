require_relative 'synchronizing'

module Publishing
  class Space < Spaces::Git::Space
    include ::Publishing::Synchronizing

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

    def import(descriptor, force:, &block)
      by_import(descriptor, force: force, &block).identifier
    end

    def by_import(descriptor, force:, &block)
      super.tap do |m|
        locations.ensure_located(m)
        blueprints.by_import(descriptor, force: force, &block)
        m.bindings.each { |b| by_import(b.descriptor, force: force, &block) } if force
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

  end
end

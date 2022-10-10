require_relative 'synchronizing'

module Publishing
  class Space < Spaces::Git::Space
    include Synchronizing

    class << self
      def default_model_class = Blueprint
    end

    delegate([:locations, :blueprints] => :universe)

    alias_method :by, :by_json
    alias_method :save, :save_json
    alias_method :imported?, :exist?

    def default_extension = :json

    def modified_at(*args)
      super(*args, as: default_extension)
    end

    def import(descriptor, args)
      by_import(descriptor, **args)
    end

    def by_import(descriptor, **args)
      f = args[:force]
      super.tap do |m|
        locations.ensure_located(descriptor)
        blueprints.by_import(descriptor, force: f)
        m.bindings.each do |b|
          dwa = b.descriptor.with_account(descriptor.account)
          by_import(dwa, **args) if (!imported?(dwa) || f)
        end
      end
    rescue ::Spaces::Errors::ImportFailure => e
      locations.exist_then_delete(descriptor)
    rescue ::Spaces::Errors::ReimportFailure => e
    end

    def export(**args)
      args[:identifier].tap do |i|
        synchronize_with(blueprints, i)
        super(locations.by(i), **args)
      end
    rescue ::Spaces::Errors::ExportFailure => e
    end

  end
end

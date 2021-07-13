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

    def import(descriptor, force: false)
      by_import(descriptor, force: force).identifier
    end

    def by_import(descriptor, force: false)
      super.tap do |m|
        locations.ensure_located(m)
        blueprints.by_import(descriptor, force: force)
        m.deep_bindings
      end
    end

  end
end

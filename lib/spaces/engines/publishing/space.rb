module Publishing
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(blueprints: :universe)

    alias_method :by, :by_json
    alias_method :save, :save_json
    alias_method :imported?, :exist?
    alias_method :super_import, :import

    def import(descriptor, force: false)
      by_import(descriptor, force: force).identifier
    end

    def by_import(descriptor, force: false)
      delete(descriptor) if force && imported?(descriptor)

      if imported?(descriptor)
        by(descriptor.identifier)
      else
        super_import(descriptor)
        by(descriptor.identifier).tap do |m|
          blueprints.by_import(descriptor, force: force)
          m.turtle_targets
        end
      end
    rescue Errno::ENOENT => e
      warn(error: e, descriptor: descriptor, verbosity: [:error])
    end

    def synchronize_with_blueprint(identifier)
      identifier.tap do |i|
        blueprints.by(i).tap do |b|
          save(b.globalized)
          copy_auxiliaries_for(b)
        end
      end
    end

    protected

    def copy_auxiliaries_for(blueprint)
      blueprint.auxiliary_folders.each { |d| copy_auxiliaries(blueprint, d) }
    end

    def copy_auxiliaries(blueprint, segment)
      "#{segment}".tap do |s|
        blueprints.path_for(blueprint).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(blueprint).join(s)) if p.exist?
        end
      end
    end

  end
end

module Publishing
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(blueprints: :universe)

    alias_method :identifiers, :simple_identifiers
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
          m.deep_bindings
        end
      end
    rescue Errno::ENOENT => e
      warn(error: e, descriptor: descriptor, verbosity: [:error])
    end

    def synchronize_with(space, identifier)
      identifier.tap do |i|
        space.by(i).tap do |m|
          save(m.globalized)
          copy_auxiliaries_for(space, m)
        end
      end
    end

    protected

    def copy_auxiliaries_for(space, model)
      model.auxiliary_files.each  { |d| copy_auxiliaries(space, model, d) }
      model.auxiliary_folders.each { |d| copy_auxiliaries(space, model, d) }
    end

    def copy_auxiliaries(space, model, segment)
      "#{segment}".tap do |s|
        space.path_for(model).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(model).join(s)) if p.exist?
        end
      end
    end

  end
end

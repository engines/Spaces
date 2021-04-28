module Blueprinting
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(publications: :universe)

    alias_method :identifiers, :simple_identifiers
    alias_method :imported?, :exist?

    def by_demand(descriptor)
      publications.by_import(descriptor).localized
    end

    def by_import(descriptor, force: false)
      delete(descriptor) if force && imported?(descriptor)

      unless imported?(descriptor)
        synchronize_with(publications, descriptor)
      end
    end

    def synchronize_with(space, identifiable)
      identifiable.tap do |i|
        space.by(i).tap do |m|
          save(m.localized)
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

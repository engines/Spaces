module Blueprinting
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(publications: :universe)

    alias_method :imported?, :exist?

    def by_demand(descriptor)
      publications.by_import(descriptor).localized
    end

    def by_import(descriptor, force: false)
      delete(descriptor) if force && imported?(descriptor)

      unless imported?(descriptor)
        synchronize_with_publication(descriptor.identifier)
      end
    end

    def synchronize_with_publication(identifier)
      identifier.tap do |i|
        publications.by(i).tap do |p|
          save(p.localized)
          copy_auxiliaries_for(p)
        end
      end
    end

    protected

    def copy_auxiliaries_for(publication)
      publication.auxiliary_folders.each { |d| copy_auxiliaries(publication, d) }
    end

    def copy_auxiliaries(publication, segment)
      "#{segment}".tap do |s|
        publications.path_for(publication).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(publication).join(s)) if p.exist?
        end
      end
    end

  end
end

module Blueprinting
  class Space < ::Spaces::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(publications: :universe)

    alias_method :imported?, :exist?

    def by_import(publication, descriptor, force: false)
      delete(publication) if force && imported?(publication)

      unless imported?(publication)
        save(publication)
        copy_auxiliaries_for(publication)
      end
    end

    protected

    def copy_auxiliaries_for(publication)
      publication.auxiliary_directories.each { |d| copy_auxiliaries(publication, d) }
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

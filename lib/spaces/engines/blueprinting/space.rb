module Blueprinting
  class Space < ::Spaces::Space
    include ::Publishing::Synchronizing

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(publications: :universe)

    alias_method :identifiers, :simple_identifiers
    alias_method :imported?, :exist?

    def binder_identifiers
      all.select(&:organization?).map(&:identifier)
    end

    def by_demand(descriptor, force: false)
      publications.by_import(descriptor, force: force).localized
    end

    def by_import(descriptor, force:)
      delete(descriptor, cascade: false) if force && imported?(descriptor)

      unless imported?(descriptor)
        synchronize_with(publications, descriptor)
      end
    end

    def cascade_deletes; [:publications] ;end

  end
end

module Blueprinting
  class Space < ::Spaces::Space
    include ::Publishing::Synchronizing

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(publications: :universe)

    alias_method :imported?, :exist?

    def cascade_deletes; [:publications] ;end

    def binder_identifiers
      all.select(&:binder?).map(&:identifier)
    end

    def by(identifiable, klass = default_model_class)
      super(identifiable.low, klass)
    end

    def exist_then_by(identifiable)
      exist_then(identifiable.low) { by(identifiable.low) }
    end

    def by_import(descriptor, force:)
      delete(descriptor, cascade: false) if force && imported?(descriptor)

      unless imported?(descriptor)
        synchronize_with(publications, descriptor)
      end
    end

  end
end

module Blueprinting
  class Space < ::Targeting::TreeSpace
    include ::Publishing::Synchronizing

    alias_method :bindables_for, :new_leaves_for

    class << self
      def default_model_class = Blueprint
    end

    delegate(publications: :universe)

    alias_method :imported?, :exist?

    def cascade_deletes = [:publications]

    def binder_identifiers = all.select(&:binder?).map(&:identifier)

    def by(identifiable, klass = default_model_class) =
      super(identifiable.low, klass)

    def exist_then_by(identifiable) =
      exist_then(identifiable.low) { by(identifiable.low) }

    def by_import(descriptor, force:)
      delete(descriptor, cascade: false) if force && imported?(descriptor)

      unless imported?(descriptor)
        synchronize_with(publications, descriptor)
      end
    end

  end
end

require_relative 'status'

module Spaces
  module Git
    class Space < ::Spaces::PathSpace

      delegate(locations: :universe)

      def by_import(descriptor, **args)
        repository_for(descriptor, **args).by_import
      end

      def export(descriptor, **args)
        repository_for(descriptor, **args).export(args.without(:stream))
      end

      def repository_for(descriptor, **args) =
        repository_class.new(
          location_maybe_already_set_for(descriptor), space: self, stream: args[:stream]
        )

      def location_maybe_already_set_for(descriptor) =
        locations.exist_then_by(descriptor) || descriptor

      def git = ::Git
      def git_error = ::Git::GitExecuteError
      def repository_class = ::Spaces::Git::Repository

    end
  end
end

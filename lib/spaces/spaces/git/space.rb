require 'git'
require_relative 'status'

module Spaces
  module Git
    class Space < ::Spaces::Space

      delegate(locations: :universe)

      def by_import(descriptor, force:, &block)
        repository_for(descriptor).by_import(force: force, &block)
      end

      def export(descriptor, **args, &block)
        repository_for(descriptor).export(**args, &block)
      end

      def repository_for(descriptor)
        repository_class.new(location_maybe_already_set_for(descriptor), space: self)
      end

      def location_maybe_already_set_for(descriptor)
        locations.exist_then_by(descriptor) || descriptor
      end

      def git; ::Git ;end
      def git_error; ::Git::GitExecuteError ;end
      def repository_class; ::Spaces::Git::Repository ;end

    end
  end
end

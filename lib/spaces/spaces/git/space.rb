module Spaces
  module Git
    class Space < ::Spaces::Space

      def by_import(descriptor, force:)
        repository_for(descriptor).by_import(force: force)
      end

      def export(descriptor, **args, &block)
        repository_for(descriptor).export(**args, &block)
      end

      def repository_for(descriptor)
        repository_class.new(descriptor, space: self)
      end

      def repository_class; ::Spaces::Git::Repository ;end

    end
  end
end

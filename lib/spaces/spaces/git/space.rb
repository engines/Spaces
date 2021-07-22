module Spaces
  module Git
    class Space < ::Spaces::Space

      def by_import(descriptor, force: false)
        repository_for(descriptor).by_import(force: force)
      end

      def export(identifiable, **args)
        repository_for(descriptor_class.new(identifier: identifiable.identifier)).export(**args)
      end

      def repository_for(descriptor)
        respository_class.new(descriptor, space: self)
      end

      def respository_class; ::Spaces::Git::Repository ;end

    end
  end
end

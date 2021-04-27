module Spaces
  module Git
    class Space < ::Spaces::Space

      def by_import(descriptor, force: false)
        respository_for(descriptor).by_import(force: force)
      end

      def respository_for(descriptor)
        respository_class.new(descriptor, space: self)
      end

      def respository_class; ::Spaces::Git::Repository ;end

    end
  end
end

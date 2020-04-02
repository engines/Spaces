require 'git'
require_relative '../uri/space'

module Outer
  module Git
    class Space < ::Outer::Uri::Space

      def encloses?(descriptor)
        Dir.exist?(path_for(descriptor))
      end

      def reading_name_for(descriptor)
        ensure_space
        Dir["#{path_for(descriptor)}/*.json"].first
      end

      def import(descriptor)
        ensure_space
        clear_for(descriptor)
        g = ::Git.clone(descriptor.value, descriptor.blueprint_identifier, path: path)
        g.checkout(descriptor.branch) if descriptor.branch
      end

      def file_names_for(directory, descriptor)
        Dir["#{path_for(descriptor)}/#{directory}/**/*"].reject { |f| File.directory?(f) }
      end

      def clear_for(descriptor)
        FileUtils.rm_rf(path_for(descriptor))
      end

    end
  end
end

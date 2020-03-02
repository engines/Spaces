require 'git'
require_relative '../uri/space'

module Outer
  module Git
    class Space < ::Outer::Uri::Space

      def encloses?(descriptor)
        Dir.exist?(subspace_path_for(descriptor))
      end

      def file_name_for(descriptor)
        ensure_space
        Dir["#{subspace_path_for(descriptor)}/*.json"].first
      end

      def import(descriptor)
        ensure_space
        clear_for(descriptor)
        g = ::Git.clone(descriptor.value, descriptor.static_identifier, path: path)
        g.checkout(descriptor.branch) if descriptor.branch
      end

      def text_file_names_for(descriptor)
        Dir["#{subspace_path_for(descriptor)}/custom_files/**/*"].reject { |f| File.directory?(f) }
      end

      def clear_for(descriptor)
        FileUtils.rm_rf(subspace_path_for(descriptor))
      end

    end
  end
end

require 'git'
require_relative '../uri/space'

module Outer
  module Git
    class Space < ::Outer::Uri::Space
      # The dimensions in which Git repos exist

      def encloses?(descriptor)
        Dir.exist?("#{path}/#{descriptor.identifier}")
      end

      def file_name_for(descriptor)
        ensure_space
        Dir["#{path}/#{descriptor.identifier}/*.json"].first
      end

      def import(descriptor)
        ensure_space
        clear_for(descriptor)
        g = ::Git.clone(descriptor.value, descriptor.identifier, path: path)
        g.checkout(descriptor.branch) if descriptor.branch
      end

      def clear_for(descriptor)
        FileUtils.rm_rf("#{path}/#{descriptor.identifier}")
      end

    end
  end
end

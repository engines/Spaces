require 'git'
require_relative '../uri/space'

module Persistence
  module Git
    class Space < ::Persistence::Uri::Space
      # The dimensions in which Git repos exist

      def encloses?(descriptor)
        Dir.exist?("#{path}/#{descriptor.identifier}")
      end

      def file_name_for(descriptor)
        Dir["#{path}/#{descriptor.identifier}/*.json"].first
      end

      def import(descriptor)
        ::Git.clone(descriptor.value, descriptor.identifier, path: path)
      end

    end
  end
end

require 'git'
require_relative '../space'

module Persistence
  module Git
    class Space < ::Framework::Space
      # The dimensions in which Git repos exist

      def import(descriptor)
        ::Git.clone(descriptor.value, descriptor.identifier, path: path)
      end

    end
  end
end

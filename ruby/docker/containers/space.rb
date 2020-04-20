require 'docker-api'
require_relative '../../spaces/space'
require_relative '../files/file'

module Docker
  module Containers
    class Space < ::Spaces::Space

      delegate([:all, :get] => :bridge)

      def create(descriptor)
        bridge.create(
          'name' => descriptor.identifier,
          'Image' => descriptor.identifier
        )
      end

      def bridge
        Docker::Container
      end

    end
  end
end

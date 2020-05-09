require 'docker-api'
require_relative '../space'

module Docker
  module Containers
    class Space < ::Docker::Space

      def bridge; Docker::Container ;end

      def create(descriptor)
        bridge.create(
          name: descriptor.identifier,
          Image: descriptor.identifier,
          Volumes: { descriptor.identifier => {} }
        )
      end

    end
  end
end

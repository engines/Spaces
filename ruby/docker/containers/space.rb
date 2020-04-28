require 'docker-api'
require_relative '../space'

module Docker
  module Containers
    class Space < ::Docker::Space

      define_method (:bridge) { Docker::Container }

      def create(descriptor)
        bridge.create(
          name: descriptor.identifier,
          Image: descriptor.identifier
        )
      end

    end
  end
end

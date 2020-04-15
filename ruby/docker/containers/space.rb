require 'docker-api'
require_relative '../../spaces/space'
require_relative '../files/file'

module Docker
  module Containers
    class Space < ::Spaces::Space

      delegate([:all, :get, :create] => :bridge)

      def bridge
        Docker::Container
      end

    end
  end
end

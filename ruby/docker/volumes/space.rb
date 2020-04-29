require 'docker-api'
require_relative '../space'

module Docker
  module Volumes
    class Space < ::Docker::Space

      define_method (:bridge) { Docker::Volume }

    end
  end
end

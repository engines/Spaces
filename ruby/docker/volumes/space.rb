require 'docker-api'
require_relative '../space'

module Docker
  module Volumes
    class Space < ::Docker::Space

      def bridge; Docker::Volume ;end

    end
  end
end

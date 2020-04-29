require_relative '../bridges/space'
require_relative '../docker/volumes/space'

module Volumes
  class Space < ::Bridges::Space

    define_method (:bridge) { @bridge ||= Docker::Volumes::Space.new }

  end
end

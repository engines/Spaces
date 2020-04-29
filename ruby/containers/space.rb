require_relative '../bridges/space'
require_relative '../docker/containers/space'

module Containers
  class Space < ::Bridges::Space

    define_method (:bridge) { @bridge ||= Docker::Containers::Space.new }

  end
end

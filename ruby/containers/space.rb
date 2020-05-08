require_relative '../bridges/space'
require_relative '../docker/containers/space'

module Containers
  class Space < ::Bridges::Space

    def bridge; @bridge ||= Docker::Containers::Space.new ;end

  end
end
